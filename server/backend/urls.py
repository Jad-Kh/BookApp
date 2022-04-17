from Django.contrib import admin
from Django.URLs import path
from server.backend import views

urlpatterns = [
    path('admin/', admin.site.urls),  
    path('', views.index, name='index'),
 
]