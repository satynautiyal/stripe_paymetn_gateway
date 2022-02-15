class PaymentsController < ApplicationController
    @data
    def create_payment
        $data=params
        session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_items: [{
                name: params[:name],
                amount:  params[:amount].to_i*100,
                quantity: params[:quantity],
                currency: 'inr',
            }], 
            mode: 'payment',
            success_url: order_place_url,
            cancel_url: payment_failed_url,
          })
        #   abort()
        redirect_to session.url
    end

    def order_place
        
        @order={"id": $data['id'],"total_amount": $data['amount'],"qty": $data['quantity'],"user_id": current_user.id}
        @order_place=Order.new(@order)  
        if @order_place.save
            respond_to do |format|
                format.html { redirect_to @order_place, notice: "Payment Successfull" }
                format.json { render :show, status: :created, location: @order_place }
            end
        end
    end

    def payment_failed
        if @order_place.save
            respond_to do |format|
                format.html { redirect_to @order_place, notice: "Payment Failed" }
                format.json { render :show, status: :created, location: @order_place }
            end
        end
    end
end