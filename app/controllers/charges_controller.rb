class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "BigMoney Membership - #{current_user.username}",
      # amount: ChargesController::Amount.default
      amount: 1500
    }
  end

  def create
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    Stripe::Charge.create(
    customer: customer.id,
    # amount: ChargesController::Amount.default,
    amount: 1500,
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

  class Amount
    def default
      1000
    end
  end
end
