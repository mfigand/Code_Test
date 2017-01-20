class Transfer < ActiveRecord::Base
  belongs_to :bank

  def self.search_other_banks_accounts(bank)
    @search_results = Bank.all.where('name != ?', bank.name)
  end

  def self.handle_intra_bank(bank,transfer)
    @sender_account = Account.where('iban = ?',transfer.sender).first
    @beneficiary_account = Account.where('iban = ?',transfer.beneficiary).first
    @amount_transfer = transfer.amount
    if @sender_account == @beneficiary_account
      @result = "ALERT! Sender and beneficiary most be different"
    elsif @sender_account.amount >= @amount_transfer.to_i
      @sender_account.amount = @sender_account.amount - @amount_transfer.to_i
      @sender_account.save
      @beneficiary_account.amount = @beneficiary_account.amount + @amount_transfer.to_i
      @beneficiary_account.save
      @result = "Succeed"
    else
      @result = "ALERT! Not enough Money in sender account, try a smaller amount"
    end
    ["INTRA",@result]
  end

  def self.handle_inter_bank(bank,transfer)
    @sender_account_inter = Account.where('iban = ?',transfer.sender).first
    @beneficiary_account_inter = Account.where('iban = ?',transfer.beneficiary).first
    @amount_transfer_inter = transfer.amount
    @random_num = Random.rand(1..10)

    if @sender_account_inter.amount < (@amount_transfer_inter.to_i + 5)
      @result_inter = "ALERT! Not enough Money in sender account, try a smaller amount"
    elsif @amount_transfer_inter.to_i > 1000
      @result_inter = "ALERT! this transfer exceeds the 1000€ limit for Inter-bank Transfers, try a smaller amount"
    elsif @random_num <= 3
      @result_inter = "This transfer fails for the 30% chance of failure"
    elsif @sender_account_inter.amount >= (@amount_transfer_inter.to_i + 5) && @amount_transfer_inter.to_i <= 1000 && @random_num > 3
      @sender_account_inter.amount = @sender_account_inter.amount - (@amount_transfer_inter.to_i + 5)
      @sender_account_inter.save
      @beneficiary_account_inter.amount = @beneficiary_account_inter.amount + @amount_transfer_inter.to_i
      @beneficiary_account_inter.save
      @result_inter = "Succeed"
    end
    ["INTER",@result_inter]
  end

end
