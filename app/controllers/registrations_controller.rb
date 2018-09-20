module DeviseTokenAuth
  class RegistrationsController < DeviseTokenAuth::ApplicationController
    def create
      p params
      @resource            = resource_class.new(sign_up_params.except(:confirm_success_url))
      # @resource.provider   = provider
      if resource_class.case_insensitive_keys.include?(:username)
        @resource.username = sign_up_params[:username].try :downcase
      else
        @resource.username = sign_up_params[:username]
      end

      @redirect_url = sign_up_params[:confirm_success_url]

      # fall back to default value if provided
      @redirect_url ||= DeviseTokenAuth.default_confirm_success_url

      # success redirect url is required
      if confirmable_enabled? && !@redirect_url
        return render_create_error_missing_confirm_success_url
      end

      # if whitelist is set, validate redirect_url against whitelist
      if DeviseTokenAuth.redirect_whitelist
        unless DeviseTokenAuth::Url.whitelisted?(@redirect_url)
          return render_create_error_redirect_url_not_allowed
        end
      end

      begin
        # override email confirmation, must be sent manually from ctrl
        resource_class.set_callback("create", :after, :send_on_create_confirmation_instructions)
        resource_class.skip_callback("create", :after, :send_on_create_confirmation_instructions)
        if @resource.respond_to? :skip_confirmation_notification!
          # Fix duplicate e-mails by disabling Devise confirmation e-mail
          @resource.skip_confirmation_notification!
        end
        p '==============='
        p @resource
        if @resource.save
          yield @resource if block_given?

          unless @resource.confirmed?
            # user will require email authentication
            @resource.send_confirmation_instructions({
                                                         client_config: params[:config_name],
                                                         redirect_url: @redirect_url
                                                     })

          else
            # email auth has been bypassed, authenticate user
            @client_id, @token = @resource.create_token

            @resource.save!

            update_auth_header
          end
          render_create_success
        else
          clean_up_passwords @resource
          render_create_error
        end
      rescue ActiveRecord::RecordNotUnique
        clean_up_passwords @resource
        # render_create_error_email_already_exists
      end
    end

    def sign_up_params
      params.permit([*params_for_resource(:sign_up), :confirm_success_url])
    end
  end
end