package net.unibave.farmacia.api.resources;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import net.unibave.farmacia.api.model.Erro;
import net.unibave.farmacia.api.model.Laboratorio;

/**
 *
 * @author camila
 */
@Stateless
@Path("laboratorios")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class LaboratorioResource {

    @PersistenceContext(unitName = "FarmaciaPU")
    private EntityManager entityManager;

    @GET
    public List<Laboratorio> findAll(@QueryParam("nome") String nome) {
        if (nome != null) {
            return entityManager
                    .createQuery("SELECT l FROM Laboratorio l WHERE LOWER(l.nome) LIKE LOWER(:nome)", Laboratorio.class)
                    .setParameter("nome", new StringBuilder("%").append(nome).append("%").toString())
                    .getResultList();
        }

        return entityManager
                .createQuery("SELECT l FROM Laboratorio l", Laboratorio.class)
                .getResultList();
    }

    @GET
    @Path("{id}")
    public Laboratorio findById(@PathParam("id") Long id) {
        Laboratorio laboratorio = entityManager.find(Laboratorio.class, id);
        if (laboratorio == null) {
            String mensagem = new StringBuilder()
                    .append("Laboratório ")
                    .append(String.valueOf(id))
                    .append(" não encontrado")
                    .toString();

            Response response = Response
                    .status(Response.Status.NOT_FOUND)
                    .entity(new Erro(mensagem))
                    .build();

            throw new WebApplicationException(response);
        }
        return laboratorio;
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Long id) {
        Laboratorio laboratorio = findById(id);
        entityManager.remove(laboratorio);
    }

    @POST
    public Laboratorio add(Laboratorio laboratorio) {
        entityManager.persist(laboratorio);
        return laboratorio;
    }

    @PUT
    @Path("{id}")
    public Laboratorio update(@PathParam("id") Long id, Laboratorio laboratorio) {
        findById(id);
        laboratorio.setId(id);
        return entityManager.merge(laboratorio);
    }

}
