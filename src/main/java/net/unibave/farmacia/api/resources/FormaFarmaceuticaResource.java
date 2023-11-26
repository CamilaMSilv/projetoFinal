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
import net.unibave.farmacia.api.model.FormaFarmaceutica;

/**
 *
 * @author camila
 */
@Stateless
@Path("formas")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class FormaFarmaceuticaResource {

    @PersistenceContext(unitName = "FarmaciaPU")
    private EntityManager entityManager;

    @GET
    public List<FormaFarmaceutica> findAll(@QueryParam("descricao") String descricao) {
        if (descricao != null) {
            return entityManager
                    .createQuery("SELECT f FROM FormaFarmaceutica f WHERE LOWER(f.descricao) LIKE LOWER(:descricao)", FormaFarmaceutica.class)
                    .setParameter("descricao", new StringBuilder("%").append(descricao).append("%").toString())
                    .getResultList();
        }

        return entityManager
                .createQuery("SELECT f FROM FormaFarmaceutica f", FormaFarmaceutica.class)
                .getResultList();
    }

    @GET
    @Path("{id}")
    public FormaFarmaceutica findById(@PathParam("id") Long id) {
        FormaFarmaceutica formaFarmaceutica = entityManager.find(FormaFarmaceutica.class, id);
        if (formaFarmaceutica == null) {
            String mensagem = new StringBuilder()
                    .append("Forma Farmacêutica ")
                    .append(String.valueOf(id))
                    .append(" não encontrada")
                    .toString();

            Response response = Response
                    .status(Response.Status.NOT_FOUND)
                    .entity(new Erro(mensagem))
                    .build();

            throw new WebApplicationException(response);
        }
        return formaFarmaceutica;
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Long id) {
        FormaFarmaceutica formaFarmaceutica = findById(id);
        entityManager.remove(formaFarmaceutica);
    }

    @POST
    public FormaFarmaceutica add(FormaFarmaceutica formaFarmaceutica) {
        entityManager.persist(formaFarmaceutica);
        return formaFarmaceutica;
    }

    @PUT
    @Path("{id}")
    public FormaFarmaceutica update(@PathParam("id") Long id, FormaFarmaceutica formaFarmaceutica) {
        findById(id);
        formaFarmaceutica.setId(id);
        return entityManager.merge(formaFarmaceutica);
    }

}
