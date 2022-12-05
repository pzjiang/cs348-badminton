class JoinReq < ApplicationRecord
    # Enforce valid roles
    VALID_ROLES = ['Player','Team Admin','Referee','System Admin']
    validates :role, presence: true, inclusion: {in: VALID_ROLES}

    # Enforce valid status options
    VALID_STATUSES = ['Pending','Accepted','Deleted']
    validates :status, presence: true, inclusion: {in: VALID_STATUSES}
end

# create_table "join_reqs", force: :cascade do |t|
#     t.string "req_name"
#     t.string "req_role"
#     t.integer "team_id"
#     t.string "status"
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#   end