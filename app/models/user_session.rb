class UserSession < Authlogic::Session::Base

  # Permite que o usuário efetue o log in tanto por login como por e-mail
  find_by_login_method :find_by_login_or_email

  remember_me_for 2.weeks
  remember_me false

  private
  def self.oauth_consumer
    OAuth::Consumer.new("UZMwFFA9gZFW5nd6SMCubQ", "D0ITY1wdZfrvC6dr4NMTy6NVWOEV3juxidiKVqJaY",
                        { :site=>"http://twitter.com",
                          :authorize_url => "http://twitter.com/oauth/authenticate" })
  end

  def update_user_activity
    controller.session[:last_active] = self.record.sb_last_seen_at
    controller.session[:topics] = controller.session[:forums] = {}
    self.record.update_last_seen_at
  end

end
