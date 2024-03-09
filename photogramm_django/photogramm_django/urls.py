"""
URL configuration for photogramm_django project.

    https://docs.djangoproject.com/en/5.0/topics/http/urls/
"""

from api import views
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path
from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularRedocView,
    SpectacularSwaggerView,
)
from rest_framework import routers

router = routers.DefaultRouter()
router.register("models", views.MeshModelViewSet)
# router.register("gallery", views.GalleryModelViewSet)
# router.register("image", views.MeshImageModelViewSet)

urlpatterns = [
    path("", include(router.urls)),
    path("api-auth/", include("rest_framework.urls", namespace="rest_framework")),
    path("admin/", admin.site.urls),
    path("schema/", SpectacularAPIView().as_view(), name="schema"),
    path(
        "image/",
        views.MeshImageModelViewSet.as_view(),
        name="image-create",
    ),
    path(
        "model/",
        views.MeshModelCreate.as_view(),
        name="model-create",
    ),
    path(
        "gallery/",
        views.GalleryModelCreate.as_view(),
        name="gallery-create",
    ),
    path(
        "schema/swagger-ui/",
        SpectacularSwaggerView().as_view(url_name="schema"),
        name="swagger-ui",
    ),
    path(
        "schema/redoc/",
        SpectacularRedocView().as_view(url_name="schema"),
        name="redoc",
    ),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
