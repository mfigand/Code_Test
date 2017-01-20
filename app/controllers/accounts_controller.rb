class AccountsController < ApplicationController

  def index
    @bank = Bank.find(params[:bank_id])
    @accounts = @bank.accounts
  end

  def new
    @bank = Bank.find(params[:bank_id])
    @account = Account.new
  end

  def create
    @account = Account.new account_params
    @account.bank_id = params[:bank_id]
    if @account.save
      flash[:notice] = "Account created succesfully"
      render "show"
    else
      flash[:alert] = "ALERT! Account not created"
      render 'new'
    end
  end

  def edit
    @bank = Bank.find(params[:bank_id])
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes account_params
      @message = "Tranferencia realizada con éxito!"
      render "show"
    else
      render "edit"
    end

  end

  def show
    @bank = Bank.find(params[:bank_id])
    @account = Account.find(params[:id])
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to bank_path(params[:bank_id])
  end

  private

  def account_params
   params.require(:account).permit(:iban, :amount, :holder)
  end

end
