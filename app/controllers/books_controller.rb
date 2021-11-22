class BooksController < ApplicationController
    def index
        @allbooks = Book.all
        @user = current_user 
    end

    def bookDetails
        @bookid = Book.find(params[:id])
        @title = @bookid.title
        #render 'bookDetails'
    end

    def mybooks
        @user = current_user
        @allmybooks = @user.books
        #render 'mybooks'
    end

    def adminaccess
        @allbooks = Book.all
        @user = current_user
        if @user.admin?
            render 'admin'

        end
    end

    def update
        @editbook = Book.find(params[:id])
        respond_to do |format|
            format.html do
                @editbook.fetch(:editbook).update(params.require(:editbook).permit(:title, :author, :genre, :sub_genre, :pages, :publisher, :copies))
            end
        end
    end

    def edit
        @editbook = Book.find(params[:id])
    end

    def checkout
        @book1 = Book.find(params[:id])
        @user = current_user
        
        if @user.books.find_by_id(@book1)
            flash[:alert] = "Book already checked out!"
        else
            @user.books << @book1
            @book1.copies = @book1.copies.to_i - 1 #copies not subtracting for some reason
            @book1.save
            @user.books.last.checkoutdate = DateTime.now
        end

        #@book1.checkedoutusers.clear
        #@user.books.clear
        #@user.user_books.clear
        puts @user.books.last.checkoutdate
        puts @user.books
        puts @book1.copies
        puts @user.user_books.find_by_id(1)
        puts @book1.checkedoutusers
    end
    
    def return
        @booktoreturn = Book.find(params[:id])
        @user = current_user
        @booktoreturn.copies = @booktoreturn.copies + 1
        @booktoreturn.save
        @user.books.delete(Book.find(@booktoreturn.id))
    end

end