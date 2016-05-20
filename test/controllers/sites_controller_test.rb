require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  setup do
    @site = sites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site" do
    assert_difference('Site.count') do
      post :create, site: { about_bride: @site.about_bride, about_groom: @site.about_groom, bride_name: @site.bride_name, event_planner: @site.event_planner, groom_name: @site.groom_name, photographer: @site.photographer, template_id: @site.template_id, user_id: @site.user_id, wedding_date: @site.wedding_date }
    end

    assert_redirected_to site_path(assigns(:site))
  end

  test "should show site" do
    get :show, id: @site
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site
    assert_response :success
  end

  test "should update site" do
    patch :update, id: @site, site: { about_bride: @site.about_bride, about_groom: @site.about_groom, bride_name: @site.bride_name, event_planner: @site.event_planner, groom_name: @site.groom_name, photographer: @site.photographer, template_id: @site.template_id, user_id: @site.user_id, wedding_date: @site.wedding_date }
    assert_redirected_to site_path(assigns(:site))
  end

  test "should destroy site" do
    assert_difference('Site.count', -1) do
      delete :destroy, id: @site
    end

    assert_redirected_to sites_path
  end
end
