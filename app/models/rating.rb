class Rating < ApplicationRecord
    validates :comment, presence: true
    belongs_to :place
    belongs_to :user

    after_commit :update_status

    def self.return_data
        self.joins(:user, :place)
            .select("ratings.id, users.name AS created_by,
                     ratings.comment, ratings.score, ratings.created_at"
                    ).as_json
    end

    private 

    def update_status
        place_rating_status = Rating.where(place_id: self.place_id)
                                    .pluck("AVG(score), COUNT(*)").first
        
        Place.where(id: self.place_id)
             .update(total_rating: place_rating_status[1].to_i, 
                     rating_avg: place_rating_status[0].to_f)
    end
end
