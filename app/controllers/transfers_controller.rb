class TransfersController < ApplicationController

  def new
    @bank = Bank.find(params[:bank_id])
    @transfer = Transfer.new
    flash[:alert] = @result_message
  end

  def new_inter_transfers
    @bank = Bank.find(params[:bank_id])
    @other_banks_accounts = Transfer.search_other_banks_accounts(@bank)
    @transfer = Transfer.new
    flash[:alert] = @result_message
  end

  def create
    @bank = Bank.find(params[:bank_id])
    @transfer = Transfer.new transfer_params
    @transfer.bank_id = params[:bank_id]

    if @transfer.transfer_type == 'Intra-bank'
      @result_message = Transfer.handle_intra_bank(@bank,@transfer)
    else
      @result_message = Transfer.handle_inter_bank(@bank,@transfer)
    end

    if @result_message[1] == 'Succeed' && @result_message[0] == "INTRA"
      @transfer.status = @result_message[1]
      @transfer.save
      render "show"
    elsif @result_message[1] == 'Succeed' && @result_message[0] == "INTER"
      @transfer.status = @result_message[1]
      @transfer.save
      render "show"
    elsif @result_message[1] != 'Succeed' && @result_message[0] == "INTRA"
      flash[:alert] = @result_message[1]
      render "new"
    elsif @result_message[1] != 'Succeed' && @result_message[0] == "INTER"
      flash[:alert] = @result_message[1]
      @other_banks_accounts = Transfer.search_other_banks_accounts(@bank)
      render "new_inter_transfers"
    end
  end

  def show
    @transfer = Transfer.find(params[:id])
  end

  def destroy
    @transfer = Transfer.find_by(id: params[:id])
    @transfer.destroy
    redirect_to bank_path(params[:bank_id])
  end

  private

  def transfer_params
    params.require(:transfer).permit(:sender, :beneficiary, :amount, :status, :transfer_type)
  end

end
