class Main
  helpers do
    def logged_in?
      return false unless request.cookies.has_key?("user_challenge") && request.cookies.has_key?("user")
      
      @user = User.get(request.cookies['user'])
      return false if @user.nil?
      
      @user = nil unless @user.challenges && @user.challenges.include?(request.cookies['user_challenge'])
      return false if @user.nil?
      
      return true
    end
    
    # Your helpers go here. You can also create another file in app/helpers with the same format.
    # All helpers defined here will be available across all the application.
    #
    # @example A helper method for date formatting.
    #
    #   def format_date(date, format = "%d/%m/%Y")
    #     date.strftime(format)
    #   end
  end
end
