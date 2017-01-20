class SiteController < ApplicationController
  def home
    @bank = Bank.all
  end
end
