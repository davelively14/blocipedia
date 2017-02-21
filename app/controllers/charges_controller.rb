class ChargesController < ApplicationController
  def new
    authorize :charge
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "BigMoney Membership - #{current_user.username}",
      amount: amount
    }
  end

  def create
    authorize :charge
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    Stripe::Charge.create(
    customer: customer.id,
    amount: amount,
    description: "BigMoney Membership - #{current_user.username}",
    currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.username}! Feel free to pay me again."
    current_user.premium!
    redirect_to wikis_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def destroy
    authorize :charge
    current_user.standard!
    redirect_to wikis_path
  end

  private

  def amount(terms=nil)
    case terms
    when :half_off
      return 750
    when :standard_sale
      return 1000
    else
      return 1500
    end
  end
end
