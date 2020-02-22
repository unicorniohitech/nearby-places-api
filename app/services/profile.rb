class Profile
    attr_reader :errors, :response

    def initialize(user_id)
        @response = []
    end

    def prepare_profile
        @response = query

        @response

    rescue ActiveRecord::RecordNotFound => e
        render json: { errors: 'Unable to find Places' }, status: 403
    end

    private

    def query
        User.left_joins(:ratings, :places)
            .group("users.name, users.email, users.created_at")
            .select("users.name, users.email, users.created_at, 
                     COUNT(places.*) AS created_places, 
                     COUNT(ratings.*) AS created_ratings"
            ).as_json
    end
end