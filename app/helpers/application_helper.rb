module ApplicationHelper
  
  def activity_count(id)
  
    new_client = @client.retrieve_another_athlete(id)
    return new_client
      end
 
    def sortable(column, title = nil)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end


  
    private
    def setup
        @client = Strava::Api::V3::Client.new(:access_token => "d2dec4a10054c06202531f321a93e7a0d14e87a0")
    end
end
