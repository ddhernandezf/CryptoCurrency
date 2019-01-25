app.controller('RegistroCtrl', function ($rootScope, $scope, $http) {
    $scope.ModeloRegistro = {
        vPatrocinador: PatrocinadorAsignador,
        vNombreUsuario: null, 
        vNombres: null, 
        vApellidos: null, 
        vCorreoElectronico: null, 
        vCarteraCryptoMoneda: null,
        vContrasena: null,
        vConfirmaContrasena: null,
    };
    $scope.RegistroError = null;

    llamarData($http).Idiomas().then(function (response) {
        $rootScope.ModeloLenguaje = response.data;

        kdlIdioma($http, $scope, $rootScope.ModeloLenguaje.Idiomas, $rootScope.ModeloLenguaje.IdiomaSeleccionado);
    }, function (error) {
        console.log(error);
    });

    llamarData($http).Vista().then(function (response) {
        $rootScope.ModeloVista = JSON.parse(response.data.ObjetoJson);

        $('.blocker').hide();
        console.log($rootScope.ModeloVista);
    }, function (error) {
        console.log(error);
    });

    $scope.Registrar = function () {
        $('.blocker').show();

        $http.post(urlGlobal + 'Seguridad/Registrar', $scope.ModeloRegistro).then(function (response) {
            response.data = JSON.parse(response.data);
            if (response.data == true) {
                $scope.RegistroError = null;
                window.location.href = '../Home/Index';
            }
            else if (response.data == false) {
                $('.blocker').hide();
                $scope.RegistroError = 'Ocurrio un error desconocido. Reporte este error al administrador del sitio.';
            }
            else {
                $('.blocker').hide();
                $scope.RegistroError = response.data;
            }
            $('.blocker').hide();
        }, function (error) {
            $('.blocker').hide();
            $scope.RegistroError = 'Error: ' + error.status;
            $('.blocker').hide();
        });
    };
});

function llamarData($http) {
    return {
        Vista: consultarVista,
        Idiomas: consultarIdioma
    }

    function consultarVista() {
        return $http.get(urlGlobal + 'Generales/Vista?pVista=Registro');
    }

    function consultarIdioma() {
        return $http.get(urlGlobal + 'Generales/Idiomas');
    }
}