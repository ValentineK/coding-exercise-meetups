class GroupsController < ApplicationController

  LOCATION = 'Munich'

  # Almost always I have in Controller simple actions index, show, update and delete
  # due RESTful approach. May be it would be better to place both controllers to the
  # group folder since we understand group as the resource.

  def index
    @search_text = permitted_params[:query]
    unless @search_text.nil?
      @groups = Meetup::SearchGroupsService.new({
        text: @search_text,
        location: LOCATION
      }).run!.take(10)
    end
  end

  private

  def permitted_params
    params.permit(:query)
  end

end
