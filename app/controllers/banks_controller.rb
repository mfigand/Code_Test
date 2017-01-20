class BanksController < ApplicationController

  def index
  end

  def new
    @bank = Bank.new
  end

  def create
    @bank = Bank.new bank_params
    if @bank.save
      flash[:notice] = "Bank created succesfully!"
    else
      flash[:alert] = "ALERT! Bank not created"
      render 'new'
    end
  end

  def edit
    @bank = Bank.find_by(id: params[:id])
  end

  def update
    @bank = Bank.find(params[:id])
    @accounts = @bank.accounts
    @transfers = @bank.transfers
    if @bank.update_attributes bank_params
      render 'show'
    else
      render "edit"
    end

  end

  def show
    @bank= Bank.find_by(id: params[:id])
    @accounts = @bank.accounts
    @transfers = @bank.transfers
    @intra_transfers = @transfers.where('transfer_type = ?',"Intra-bank")
    @inter_transfers = @transfers.where('transfer_type = ?',"Inter-bank")
  end

  def destroy
    @bank= Bank.find_by(id: params[:id])
    @bank.destroy
    redirect_to root_path
  end

  private

  def bank_params
    params.require(:bank).permit(:name, :address, :phone, :city, :state, :country)
  end

end
