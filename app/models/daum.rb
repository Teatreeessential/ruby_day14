class Daum < ApplicationRecord
    has_many :memberships
    has_many :users, through: :memberships
    has_many :posts


    # def self.메소드명 -> 클래스 메소드
    #     로직 안에서 self를 쓸 수 없음
    # end
    
    # def 메소드명 -> 인스턴스 메소드
    #     로직 안에서 self를 쓸 수 있음
    #     self == 현재 자신의 객체를 말한다.
    
    # end

    def is_member?(user)
       self.users.include?  user  #users 테이블 안에 매개변수로 받은 user가 존재 합니까?
    end


end