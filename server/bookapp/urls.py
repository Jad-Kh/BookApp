from django.contrib import admin
from django.urls import path
from bookapp.views import books

urlpatterns = [
    path('books/', books.book_list)
]