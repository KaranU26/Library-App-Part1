class BooksController < ApplicationController

    #display home page of application with list of books
    def index 
        @allbooks = Book.all
        @user = current_user 
    end

    #method for book details page
    def bookDetails
        @bookid = Book.find(params[:id])
        @title = @bookid.title
        #render 'bookDetails'
    end

    #method for My Books page which shows users checked out books
    def mybooks
        @user = current_user
        @allmybooks = @user.books
        #render 'mybooks'
    end

    #method that renders the admin page if the user that is logged in is flagged as admin
    def adminaccess
        @allbooks = Book.all
        @user = current_user
        if @user.admin?
            render 'admin'

        end
    end

    #method used by the admin that will use a form to edit the contents of a book.
    def update
        byebug 
        @editbook = Book.find(params[:id])
        @editbook.update(title: params[:editbook][:title], author: params[:editbook][:author], genre: params[:editbook][:genre], sub_genre: params[:editbook][:sub_genre], pages: params[:editbook][:pages], publisher: params[:editbook][:publisher], copies: params[:editbook][:copies])
        redirect_to editbook_path(@editbook) 
    end

    #method used to edit the specifically selected book by the admin
    def edit
        @editbook = Book.find(params[:id])
    end

    #method that checks out the book for the user
    def checkout
        @book1 = Book.find(params[:id])
        @user = current_user
        
        if @user.books.find_by_id(@book1)
            flash[:alert] = "Book already checked out!"
        else
            @book1ref = @book1
            @book1ref.checkoutdate = Date.today
            @user.books << @book1ref
            @book1.copies = @book1.copies.to_i - 1 #copies not subtracting for some reason
            @book1.save
        end
        @currentdate = Date.today
        @user.books.each do |usercheck|
            puts usercheck.checkoutdate
            @latedate = usercheck.checkoutdate + 7.days
            if @currentdate >= @latedate
                UserMailer.post_created(@user, @book1).deliver_now       
            end
        end
    end
    
    #method that retuns the users checked out book
    def return
        @booktoreturn = Book.find(params[:id])
        @user = current_user
        @booktoreturn.copies = @booktoreturn.copies + 1
        @booktoreturn.save
        @user.books.delete(Book.find(@booktoreturn.id))
    end

end