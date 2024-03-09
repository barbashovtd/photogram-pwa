import os
import shutil
import subprocess as sp
import tempfile

from django.core.files import File
from rest_framework import generics, status, viewsets
from rest_framework.response import Response

from photogramm_django.settings import BASE_DIR, MEDIA_ROOT

from .models import Gallery, Mesh, MeshImage
from .serializers import GallerySerializer, MeshImageSerializer, MeshSerializer


class MeshModelViewSet(viewsets.ModelViewSet):
    queryset = Mesh.objects.all()
    serializer_class = MeshSerializer


class GalleryModelViewSet(viewsets.ModelViewSet):
    queryset = Gallery.objects.all()
    serializer_class = GallerySerializer


class MeshModelCreate(generics.CreateAPIView):
    queryset = Mesh.objects.all()
    serializer_class = MeshSerializer

    def post(self, request, *args, **kwargs):
        mesh_name = request.data["name"]
        gallery = Gallery.objects.get(name=mesh_name)

        q = self.get_queryset()
        mesh = q.create(name=mesh_name, gallery=gallery)

        # Mesh creation
        cmd = [os.getenv("GRAMM"), "-p", BASE_DIR / "def.mg", "-i"]

        img_dir = tempfile.mkdtemp(prefix=mesh_name + "-")
        for img in gallery.images.all():
            # ПИЗДЕЦ
            img_src = str(BASE_DIR) + img.src.url
            # img_path = img_dir + "/" + os.path.basename(img.src.url)
            shutil.copy2(img_src, img_dir)
        cmd.append(img_dir)

        cmd.extend(["-o", MEDIA_ROOT])

        sp.run(cmd)
        # Mesh creation

        # Mesh convertion
        obj_file_path = MEDIA_ROOT / "texturedMesh.obj"
        gltf_file_path = MEDIA_ROOT / "mesh" / (mesh_name + ".gltf")
        obj2gltf = shutil.which(os.getenv("CONVERT"))

        sp.run(
            [
                obj2gltf,
                "--input",
                obj_file_path,
                "--output",
                gltf_file_path,
            ]
        )
        # Mesh convertion

        mesh.mesh = File(
            open(gltf_file_path, mode="rb"), name=os.path.basename(gltf_file_path)
        )
        mesh.save()
        shutil.rmtree(img_dir)

        # return super().post(request, *args, **kwargs)
        return Response(status=status.HTTP_200_OK)


class GalleryModelCreate(generics.CreateAPIView):
    queryset = Gallery.objects.all()
    serializer_class = MeshImageSerializer

    def post(self, request, *args, **kwargs):
        # print(request.data.items())
        q = self.get_queryset()
        g = q.create(name=request.data["name"])
        g.save()

        return Response(status=status.HTTP_200_OK)
        # return super().post(request, *args, **kwargs)


class MeshImageModelViewSet(generics.CreateAPIView):
    queryset = MeshImage.objects.all()
    serializer_class = MeshImageSerializer

    # FIXME: ПИЗДЕЦ
    def post(self, request, *args, **kwargs):
        name = list(request.data.keys()).pop()
        data = request.data[name]
        # img = MeshImage(src=data)
        # img.save()
        g = Gallery.objects.get(name=request.data["gallery"])
        img = MeshImage(src=data)
        img.save()
        if not g.images:
            g.images = img
        else:
            g.images.add(img)

        g.save()
        # return super().post(request, *args, **kwargs)
        return Response(status=status.HTTP_200_OK)
