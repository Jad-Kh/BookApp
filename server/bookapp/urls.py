from rest_framework import routers
from .api import BookViewSet

router = routers.DefaultRouter()
router.register('api/books', BookViewSet, 'bookapp')

urlpatterns = router.urls