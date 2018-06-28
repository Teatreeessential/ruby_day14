class User < ApplicationRecord
    has_secure_password
    validates :user_name, uniqueness: true # 테이블에 이 값이 있으면 에러를 뿜뿜!
    # user_name 칼럼에 unique 속성 부여
    
    has_many :memberships
    has_many :daums, through: :memberships
    has_many :posts
end