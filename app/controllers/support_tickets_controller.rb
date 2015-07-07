class SupportTicketsController < ApplicationController

  skip_before_filter :require_login
  layout 'landing'

  def new
    @support_ticket = SupportTicket.new
  end

  def create
    @support_ticket = SupportTicket.new(support_ticket_params)
    if @support_ticket.save
      redirect_to root_path
      flash[:notice] = "We will get back to you shortly"
    else
      render :new
    end
  end

  private
      def support_ticket_params
        params.require(:support_ticket).permit(:name, :email, :title, :question)
      end
end
