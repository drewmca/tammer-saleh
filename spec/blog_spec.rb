#!/bin/env rspec

require "spec_helper"

describe "Given some blog posts" do
  before do
    create_template("layouts/application.html.haml", 
                    <<-EOF)
                      %h1 Layout
                      = yield
                    EOF

     
    create_template("posts.html.haml", 
                    <<-EOF)
                      This is the Blog!
                      - posts.each do |post|
                        %h2= post.meta[:title]
                    EOF

    create_template("posts/a_post.html.haml", 
                    <<-EOF)
                      // ---
                      // title: First post
                      // date:  1997-07-01
                      // ---
                      This is the first post.
                    EOF

    create_template("posts/another_post.html.haml", 
                    <<-EOF)
                      // ---
                      // title: Second post
                      // date:  2011-01-10
                      // ---
                      This is the second post.
                    EOF
  end

  context "GET /posts" do
    before { visit "/posts" }

    it "renders the page" do
      page.source.should =~ /This is the Blog/
    end
    
    it "renders the layout" do
      page.should have_selector('h1:contains("Layout")')
    end

    it "renders the first post title" do
      page.should have_selector('h2:contains("First post")')
    end

    it "renders the second post title" do
      page.should have_selector('h2:contains("Second post")')
    end
  end

  # context "GET /posts/a_post" do
  #   before { visit "/posts/a_post" }

  #   it "renders the layout" do
  #     page.should have_selector('h1:contains("Layout")')
  #   end

  #   it "renders the post title" do
  #     page.should have_selector('h2:contains("First post")')
  #   end
  # end
end


