class ClubsController < ApplicationController
  before_filter :setup
  helper_method :sort_column, :sort_direction
  
  def index
    
    @athletes = Athlete.all
    @club = @client.retrieve_a_club("236084")
  end
  
  def update_activities
    
    #update activity table
    @bc_activities = Activity.where(activity_type: "BackcountrySki")
    @club_activities = @client.list_club_activities("236084", per_page: 200, page: 1) 
    @club = @client.retrieve_a_club("236084")
    @members = @client.list_club_members("236084")
    @member_ids = []
    @activity_count = 0
    @activities = []
    
    
    @club_activities.each do |activity|
      new_activity = Activity.new(:activity_id => activity["id"].to_int, :athlete_id => activity["athlete"]["id"].to_int, :name => activity["name"], :distance => activity["distance"].to_f, :moving_time => activity["moving_time"].to_int, :elapsed_time => activity["elapsed_time"], :total_elevation_gain => activity["total_elevation_gain"].to_f, :elev_high => activity["elev_high"].to_f, :elev_low => activity["elev_low"].to_f, :activity_type => activity["type"], :start_date => activity["start_date"].to_datetime, :start_date_local => activity["start_date_local"].to_datetime, :timezone => activity["timezone"], :start_latlng => activity["start_latlng"], :end_latlng => activity["end_latlng"], :achievement_count => activity["achievement_count"].to_i, :kudos_count => activity["kudos_count"].to_i, :comment_count => activity["comment_count"].to_i, :athlete_count => activity["athlete_count"].to_i, :total_photo_count => activity["total_photo_count"].to_i, :average_speed => activity["average_speed"].to_f, :max_speed => activity["max_speed"].to_f, :calories => activity["calories"].to_f)
      new_activity.save
      @activity_count += 1
    end
    
  end
  
  def update_athletes
    @member_ids = []
    @bc_activities = Activity.where(activity_type: "BackcountrySki")
     @members = @client.list_club_members("236084")
     @members.each do |member|
       @vert = 0
       @vert_array = []
       @vert_array << 0
       @moving_time = 0 
       @mileage = 0
       @member_ids << member["id"].to_i
       @member_activities = []
       @full_name =  member["firstname"] + " " + member["lastname"]
       @max_vert = 0
       @sessions = 0
       @max_elevation_gain = 0
       @max_time = 0
       @max_distance = 0
       @weekly_time = 0
        @weekly_elevation = 0
       
       #update athlete table
       @bc_activities.each do |activity|
         if activity.athlete_id == member["id"]
           @member_activities << activity 
           @vert_array << activity.total_elevation_gain
           @vert = @vert + activity.total_elevation_gain
           @moving_time = @moving_time + activity.moving_time
           @mileage = @mileage + activity.distance
           @sessions += 1 
           if activity.total_elevation_gain > @max_elevation_gain
             @max_elevation_gain = activity.total_elevation_gain
           end
           
           if activity.distance > @max_distance
             @max_distance = activity.distance
           end
           
           if activity.total_elevation_gain > @max_elevation_gain
             @max_elevation_gain = activity.total_elevation_gain
           end
          
           if Time.now.strftime("%W").to_i == Time.at(activity.start_date).utc.strftime("%W").to_i
           @weekly_time = @weekly_time + activity.elapsed_time
           @weekly_elevation = @weekly_elevation + activity.total_elevation_gain
           end

         end 
         #add data to athlete table
         if Athlete.find_by_strava_id(member["id"]) == nil
         Athlete.new(:name => @full_name, :strava_id => member["id"], :picture => member["profile_medium"], :weekly_mileage => 0, :alltime_mileage => @mileage, :weekly_elevation => @weekly_elevation, :alltime_elevation => @vert, :weekly_time => @weekly_time, :total_time => @moving_time, :weekly_max_speed => 0, :alltime_max_speed => 0, :sessions => @sessions, :max_elevation_gain => @max_elevation_gain, :max_distance => @max_distance, :max_time => @max_time).save
         else
           athlete = Athlete.find_by_strava_id(member["id"])
           athlete.update(:weekly_mileage => 0, :alltime_mileage => @mileage, :weekly_elevation => @weekly_elevation, :alltime_elevation => @vert, :weekly_time => @weekly_time, :total_time => @moving_time, :weekly_max_speed => 0, :alltime_max_speed => 0)
           athlete.save
         end
       end
     end
  end
  
  def show
    #@club = @client.club_show(params[:id])
  end

  def members

  end
  

  private
  def setup
     @client = Strava::Api::V3::Client.new(:access_token => "d2dec4a10054c06202531f321a93e7a0d14e87a0")
  end
  def sort_column
    Activity.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
