class CafesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    #전체 카페 목록 보여주는 페이지
    # ->  로그인 하지 않았을 때:전체 카페 목록
    # ->  로그인 했을 때: 유저가 가입한 카페목록
    def index
        @cafes = Daum.all
    end
    
    
    # 카페를 내용물을 보여주는 show 페이지 (이 카페의 게시글)
    def show
        @cafe = Daum.find(params[:id])
        #session[:current_cafe] = @cafe.id
    end
    # 카페를 개설하는 페이지
    def new
        @cafe = Daum.new
    end
    # 카페를 실제로 개설하는 로직
    def create
        @cafe = Daum.new(daum_params)
        @cafe.master_name = current_user.user_name
        
        if @cafe.save
            Membership.create(daum_id: @cafe.id,user_id: current_user.id)
            redirect_to cafe_path(@cafe), flash: {success: '카페가 개설되었습니다.'}
        else
            redirect_to :back, flash: {danger: '카페 생성이 실패했습니다'}
        end
    end
    
    def join_cafe
        Membership.create(daum_id: params[:cafe_id],user_id: current_user.id)
        redirect_to :back , flash: {success: "카페 가입에 성공했습니다."}
    end
    
    def edit
    end
    
    
    # 카페 정보를 실제로 수정하는 로직 
    def update
        @cafe=Daum.find(params[:id])
        @cafe.update(title: params[:title],
                         description: params[:description],
                         master_name: params[:master_name])
        if(@cafe.save)
            redirect_to cafes_path, flash: {success: '카페정보가 수정되었습니다.'}
        else
            redirect_to :back, flash: {error: '카페수정이 실패했습니다.'}
        end
    end
    
    private
    def daum_params
        params.require(:daum).permit(:title,:description)
    end
    
end
