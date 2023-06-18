class VtubersController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]

  def index
    @total_vtubers =Vtuber.all
    @vtubers = Vtuber.where(status: :true).order(params[:sort]).page(params[:page]).per(8)
    @vtuber= Vtuber.new
    @tag_list = Tag.all
  end

  def new
    @vtuber =Vtuber.new
  end

  def show
    @vtuber = Vtuber.find(params[:id])
    @vtuber_new = Vtuber.new
    @vtuber_comment = VtuberComment.new
    @vtuber_tags = @vtuber.tags
  end

  def edit
    @vtuber = Vtuber.find(params[:id])
    user = User.find(params[:id])
    @tag_list=@vtuber.tags.pluck(:tag_name).join(',')
    unless user.id == current_user.id
      redirect_to vtuber_path
    end
  end

  def create
    @vtuber =current_user.vtubers.new(vtuber_params.select{|k,v| k != "tag_name"})
    @vtuber.user_id = current_user.id
    #受け取った値を,で区切って配列にする
    tag_list=params[:vtuber][:tag_name].split(',')
    if @vtuber.save
      @vtuber.save_tag(tag_list)
      # byebug
      redirect_to vtubers_path(@vtuber),notice: '投稿完了しました:)'
    else
      render :new
    end
  end


  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list =Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    @vtubers = @tag.vtubers.page(params[:page]).per(10)

  end


  def destroy
    @vtuber = Vtuber.find(params[:id])
    @vtuber.destroy
    redirect_to "/vtubers"
  end

  def update
    # vtuberのidもってくる
    @vtuber = Vtuber.find(params[:id])
    #入力されたタグを受け取る
    # もしvtuberの情報が更新されたら
    if @vtuber.update(vtuber_params)

        #古いタグの関連を取得
         @vtuber.vtuber_tags.destroy_all

        #新しいタグの関連を保存
        tag_list = params[:vtuber][:tag_name].split(",").map(&:strip)
        @vtuber.save_tag(tag_list)

        redirect_to vtuber_path(@vtuber.id),notice: '投稿完了しました:)'

    else
      render :edit
    end
  end

    private

  def vtuber_params
    params.require(:vtuber).permit(:name,:belonging_office,:fan_name,:debut_day,:registered_person,:profile,:image,:user_id,:status)
  end
end