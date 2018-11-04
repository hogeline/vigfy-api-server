class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: response_fields({user: @user, styles: @styles}.to_json)
  end

  # POST /users
  def create
    puts user_params
    @user = User.new(user_params)
    if @user.name.blank? || @user.startdate.blank? || @user.enddate.blank?
      # 必須パラメータが欠けている場合
      response_bad_request
    elsif @user.save
      # ユーザ登録成功
      response_success(:user, :create)
    else
      # 何らかの理由で失敗
      response_internal_server_error
    end
  end
  
  # POST /users/1/styles
  def measure
    @styles = Style.new(style_params)
    if @styles.user_id.blank? || @styles.weight.blank? || @styles.height.blank? || @styles.bodyfat.blank?
      # 必須パラメータが欠けている場合
      response_bad_request
    elsif @styles.save
      # スタイル登録成功
      response_success(:styles, :create)
    else
      response_internal_server_error
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      response_success(:user, :update)
    else
      response_internal_server_error
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    response_success(:user, :destroy)
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    # 取得しようとしたユーザが存在しない
    response_not_found(:user) if @user.blank?
    @styles = Style.where(user_id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :startdate, :enddate)
  end
  
  def style_params
    params.require(:styles).permit(:user_id, :weight, :height, :bodyfat, :leftarm, :rightarm, :body, :leftleg, :rightleg)
  end
  
  # 他のコントローラでも除外したいフィールドが同じであれば、共通メソッドとして扱っても良い
  def response_fields(user_json)
    user_parse = JSON.parse(user_json)
    # レスポンスから除外したいパラメータ
    response = user_parse.except('updated_at', 'deleted_at')
    # JSON を見やすく整形して返す
    JSON.pretty_generate(response)
  end
end
