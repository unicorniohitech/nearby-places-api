class Api::V1::MapPlaces
    attr_reader :errors, :response

    def initialize(latitude, longitude)
        @latitude = latitude
        @longitude = longitude
        @response = []
    end

    def prepare_map
        @response = query

        @response

    rescue ActiveRecord::RecordNotFound => e
        render json: { errors: 'Unable to find Places' }, status: 403
    end

    private

    def query
        Place.joins(:user)
             .near([@latitude, @longitude], 1000)
             .select("places.*, users.name AS created_by"
             ).as_json
    end
end