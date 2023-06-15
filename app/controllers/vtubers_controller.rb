class VtubersController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]

  def index
    @total_vtubers =Vtuber.all
    @vtubers = Vtuber.all.page(params[:page]).per(8)
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
    @tag_list=@vtuber.tags.pluck(:name).jpin(',')
    unless user.id == current_user.id
      redirect_to vtuber_path
    end
  end

  def create
    @vtuber =Vtuber.new(vtuber_params)
    @vtuber.user_id = current_user.id
    #受け取った値を,で区切って配列にする
    tag_list=params[:vtuber][:name].split(',')
    if @vtuber.save
      @vtuber.save_tag(tag_list)
      redirect_to vtubers_path(@vtuber),notice: '投稿完了しました:)'
    else
      render :new
    end
  end

  def save_tag(sent_tags)
    #タグが存在していれば、タグの名前を配列として全て取得
     current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_vtuber_tag = Tag.find_or_create_by(name: new)
      self.tags << new_vtuber_tag
   end
  end

  def destroy
    @vtuber = Vtuber.find(params[:id])
    @vtuber.destroy
    redirect_to "/vtubers"
  end

  def update
    @vtuber = Vtuber.find(params[:id])
    tag_list=params[:vtuber][:name].split(',')
    if @vtuber.update(vtuber_params)
      @vtuber.save_tag(tag_list)
      redirect_to vtuber_path(@vtuber.id),notice: '投稿完了しました:)'
    else
      render "edit"
    end
  end

    private

  def vtuber_params
    params.require(:vtuber).permit(:name,:belonging_office,:fan_name,:debut_day,:registered_person,:profile,:image,:user_id,:category)
  end
end