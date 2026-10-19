class Equipo{
   
    const nombre;
    const nivelDeEnergiaBase;
    const tecnologiasComplementarias = #{};
    const entrenador;

    method nombre() = nombre;
    method nivelDeEnergiaBase() = nivelDeEnergiaBase;
    method tecnologiasComplementarias() = tecnologiasComplementarias;
    method entrenador() = entrenador;
    method tecnologiasComplementariasActivas() = tecnologiasComplementarias.filter({tecnologia => tecnologia.activa()});
    method energiaTotal() = nivelDeEnergiaBase + self.tecnologiasComplementariasActivas().sum({tecnologia => tecnologia.valorEnergetico()});
    method esDePrestigioUniversal()
}

class EquipoLuminico inherits Equipo{
    const nivelDeRadiacionCapturada;
    const cristalesSolaresAmplificadores = [];

    method nivelDeRadiacionCapturada() = nivelDeRadiacionCapturada;
    method cristalesSolaresAmplificadores() = cristalesSolaresAmplificadores;
    override method energiaTotal(){
        if(self.nivelDeRadiacionCapturada() <= 5000){
            return super() * 1.1;
        } else{
            return super()
        }
    }
    override method esDePrestigioUniversal(){
        return self.cristalesSolaresAmplificadores().size() >= 3 &&
                self.entrenador().esEliteGalactico() &&
                !self.tecnologiasComplementariasActivas().isEmpty()
    }

}

class EquipoSintetico inherits Equipo{
    const nivelDeProcesamientoCentral;
    const cantidadDeModulosActivos;
    const estaCertificadoComoUnidadEstableDeCompeticion;

    method nivelDeProcesamientoCentral() = nivelDeProcesamientoCentral;
    method cantidadDeModulosActivos() = cantidadDeModulosActivos;
    method estaCertificadoComoUnidadEstableDeCompeticion() = estaCertificadoComoUnidadEstableDeCompeticion;

    override method energiaTotal(){
        if(self.cantidadDeModulosActivos() > 5){
            return super() * 0.8
        } else {
            return super()
        }
    } 
    override method esDePrestigioUniversal(){
        return self.estaCertificadoComoUnidadEstableDeCompeticion() &&
                self.cantidadDeModulosActivos() > 3 &&
                self.tecnologiasComplementarias().all({ tecnologia => tecnologia.activa() })
    }
   
}
class EquipoEterico inherits Equipo{
    const nivelDeFluctuacionDimensional;
    const cantidadDePortalesEnergeticosAbiertos;

    method nivelDeFluctuacionDimensional() = nivelDeFluctuacionDimensional;
    method cantidadDePortalesEnergeticosAbiertos() = cantidadDePortalesEnergeticosAbiertos;
}

class Entrenador{
    const cantidadCiclosSolaresDeExperiencia;
    const estaEnSintoniaConSuEquipo;
    const nivelDePrecisionEstrategica;
    var rol;
    

    method initialize(){
        self.validarRol(rol)
    }
    method rol() = rol;
    method cantidadCiclosSolaresDeExperiencia() = cantidadCiclosSolaresDeExperiencia;
    method estaEnSintoniaConSuEquipo() = estaEnSintoniaConSuEquipo;
    method nivelDePrecisionEstrategica() = nivelDePrecisionEstrategica;
    method esEliteGalactico() = self.cantidadCiclosSolaresDeExperiencia() > 10 && rol.cumpleCondicionDeElite(self)

    method asignarRol(nuevoRol){
         self.validarRol(nuevoRol)
         rol = nuevoRol;
    }

    method esRolHomologado(unRol){
        const rolesValidos = #{estrategaCuantico, arquitectoEnergia, guiaMental};
        return rolesValidos.contains(unRol);
    }

    method validarRol(unRol) {
        if (!self.esRolHomologado(unRol)) {
            self.error("Rol no homologado por la FOZ")
        }
    }

}

class Tecnologia{
    const nombre;
    const valorEnergetico;
    const activa;

    method nombre() = nombre;
    method valorEnergetico() = valorEnergetico;
    method activa() = activa;
}

object estrategaCuantico{
    method cumpleCondicionDeElite(entrenador){
        return entrenador.nivelDePrecisionEstrategica() > 80
    }
    
}

object arquitectoEnergia{
    method cumpleCondicionDeElite(entrenador){
        return entrenador.estaEnSintoniaConSuEquipo()
    }
}
object guiaMental{
    method cumpleCondicionDeElite(entrenador){
        return true
    }
}
