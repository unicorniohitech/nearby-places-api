class Api::V1::ListPlaces
    attr_reader :errors, :response

    def initialize()
        @response = []
    end

    def prepare_list
        @response = query

        @response

    rescue ActiveRecord::RecordNotFound => e
        render json: { errors: 'Unable to find Places' }, status: 403
    end

    private

    def query
        Place.joins(:user)
             .order(name: :asc)
             .select("places.*, users.name AS created_by"
             ).as_json
    end
end