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
import net.unibave.farmacia.api.model.Unidade;

/**
 *
 * @author camila
 */
@Stateless
@Path("unidades")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class UnidadeResource {

    @PersistenceContext(unitName = "FarmaciaPU")
    private EntityManager entityManager;

    @GET
    public List<Unidade> findAll(@QueryParam("sigla") String sigla) {
        if (sigla != null) {
            return entityManager
                    .createQuery("SELECT u FROM Unidade u WHERE LOWER(u.sigla) LIKE LOWER(:sigla)", Unidade.class)
                    .setParameter("sigla", new StringBuilder("%").append(sigla).append("%").toString())
                    .getResultList();
        }

        return entityManager
                .createQuery("SELECT u FROM Unidade u", Unidade.class)
                .getResultList();
    }

    @GET
    @Path("{id}")
    public Unidade findById(@PathParam("id") Long id) {
        Unidade unidade = entityManager.find(Unidade.class, id);
        if (unidade == null) {
            String mensagem = new StringBuilder()
                    .append("Unidade ")
                    .append(String.valueOf(id))
                    .append(" não encontrada")
                    .toString();

            Response response = Response
                    .status(Response.Status.NOT_FOUND)
                    .entity(new Erro(mensagem))
                    .build();

            throw new WebApplicationException(response);
        }
        return unidade;
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Long id) {
        Unidade unidade = findById(id);
        entityManager.remove(unidade);
    }

    @POST
    public Unidade add(Unidade unidade) {
        entityManager.persist(unidade);
        return unidade;
    }

    @PUT
    @Path("{id}")
    public Unidade update(@PathParam("id") Long id, Unidade unidade) {
        findById(id);
        unidade.setId(id);
        return entityManager.merge(unidade);
    }

}
