class FavoritesController < BaseController
  before_filter :login_required
  
  
  def favorite
    @favorite = current_user.add_favorite(params[:type], params[:id] )
    
    favoritable = ''
    case params[:type]
      when 'Course'
        favoritable = "Aula"
    end
    
    if @favorite
      Log.log_activity(@favorite, 'favorite', current_user)
      
      flash.now[:notice] = favoritable + " adicionado ao seus favoritos!"
      respond_to do |format|
        format.js 
      end
    else
      flash.now[:error] = favoritable + " não foi adicionado ao seus favoritos" 
      
      respond_to do |format|
        format.js 
      end
    end
  end  
end
