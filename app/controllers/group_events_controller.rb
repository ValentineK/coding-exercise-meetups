class GroupEventsController < ApplicationController

  def index
    @events = Meetup::GroupEventsService.new({
      group_urlname: permitted_params[:group_urlname]
    }).run!.take(3)

    render layout: false
  end

  private

  def permitted_params
    params.permit(:group_urlname)
  end

end
