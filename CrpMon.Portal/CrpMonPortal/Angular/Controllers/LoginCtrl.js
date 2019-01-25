app.controller('LoginCtrl', function ($rootScope, $scope, $http) {
    $rootScope.ModeloVista = null;
    $rootScope.ModeloLenguaje = null;
    $scope.ModeloLogin = { vNombreUsuario: null, vContrasena: null };
    $scope.AutenticarError = null;

    llamarData($http).Idiomas().then(function (response) {
        $rootScope.ModeloLenguaje = response.data;

        kdlIdioma($http, $scope, $rootScope.ModeloLenguaje.Idiomas, $rootScope.ModeloLenguaje.IdiomaSeleccionado);
    }, function (error) {
        console.log(error);
    });

    llamarData($http).Vista().then(function (response) {
        $rootScope.ModeloVista = JSON.parse(response.data.ObjetoJson);

        $('.blocker').hide();
    }, function (error) {
        console.log(error);
    });

    $scope.Ingresar = function () {
        $('.blocker').show();

        $http.post(urlGlobal + 'Seguridad/Autenticar', $scope.ModeloLogin).then(function (response) {
            response.data = JSON.parse(response.data);
            if (response.data == true) {
                $scope.AutenticarError = null;
                window.location.href = urlGlobal;
            }
            else if (response.data == false) {
                $scope.AutenticarError = 'Credenciales incorrectas';
                $('.blocker').hide();
            }
            else {
                $scope.AutenticarError = response.data;
                $('.blocker').hide();
            }
        }, function (error) {
            $scope.AutenticarError = error;
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
        return $http.get(urlGlobal + 'Generales/Vista?pVista=Login');
    }

    function consultarIdioma() {
        return $http.get(urlGlobal + 'Generales/Idiomas');
    }
}