require 'spec_helper'

feature 'Admin panel' do
  context "on admin homepage" do
    it "can see a list of recent posts" do
      post = Post.create(title: "Books on Computers", content: "Learning rails the easy way.")
      visit admin_posts_path
      expect(page).to have_content('Books On Computers')
    end
    it "can edit a post by clicking the edit link next to a post" do
      Post.create(title: "Books on Computers", content: "Learning rails the easy way.")
      visit admin_posts_path
      page.has_content?('Books on Computers')

      click_link "Edit"
      expect(page).to have_content('Books On Computers')
    end

    it "can delete a post by clicking the delete link next to a post" do
      Post.create(title: "Books on Computers", content: "Learning rails the easy way.")
      visit admin_posts_path
      click_link "Delete"
      expect(page).to have_no_content('Books On Computers')
    end

    it "can create a new post and view it" do
       visit new_admin_post_url

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      Post.create(title: "Why Rails Sucks", content: "Learning how test in rails sucks.")
      visit admin_posts_url
      click_link "Edit"
      expect(page).to have_content('Why Rails Sucks')
      uncheck 'post_is_published'
      click_button "Save"
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      Post.create(title: "Why Rails Sucks", content: "Learning how test in rails sucks.")
      visit admin_posts_url
      click_link "Why Rails Sucks"
      page.should have_content("Learning how test in rails sucks.")
    end
    it "can see an edit link that takes you to the edit post path" do
      Post.create(title: "Why Rails Sucks", content: "Learning how test in rails sucks.")
      visit admin_posts_url
      click_link "Edit"
      expect(page).to have_content("Learning how test in rails sucks.")
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      post = Post.create(title: "Why Rails Sucks", content: "Learning how test in rails sucks.")
      visit admin_post_url(post.id)
      click_link "Admin welcome page"
      expect(page).to have_content("Welcome to the admin panel!")
    end
  end
end
