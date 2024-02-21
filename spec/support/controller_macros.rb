# frozen_string_literal: true

# spec/support/controller_macros.rb
module ControllerMacros
  def log_in(user)
    session[:user_id] = user.id
  end

  end
