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
import net.unibave.farmacia.api.model.Produto;

/**
 *
 * @author camila
 */
@Stateless
@Path("produtos")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class ProdutoResource {

    @PersistenceContext(unitName = "FarmaciaPU")
    private EntityManager entityManager;

    @GET
    public List<Produto> findAll(@QueryParam("nomeComercial") String nomeComercial) {
        if (nomeComercial != null) {
            return entityManager
                    .createQuery("SELECT p FROM Produto p WHERE LOWER(p.nomeComercial) LIKE LOWER(:nomeComercial)", Produto.class)
                    .setParameter("nomeComercial", new StringBuilder("%").append(nomeComercial).append("%").toString())
                    .getResultList();
        }

        return entityManager
                .createQuery("SELECT p FROM Produto p", Produto.class)
                .getResultList();
    }

    @GET
    @Path("{id}")
    public Produto findById(@PathParam("id") Long id) {
        Produto produto = entityManager.find(Produto.class, id);
        if (produto == null) {
            String mensagem = new StringBuilder()
                    .append("Produto ")
                    .append(String.valueOf(id))
                    .append(" não encontrado")
                    .toString();

            Response response = Response
                    .status(Response.Status.NOT_FOUND)
                    .entity(new Erro(mensagem))
                    .build();

            throw new WebApplicationException(response);
        }
        return produto;
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Long id) {
        Produto produto = findById(id);
        entityManager.remove(produto);
    }

    @POST
    public Produto add(Produto produto) {
        entityManager.persist(produto);
        return produto;
    }

    @PUT
    @Path("{id}")
    public Produto update(@PathParam("id") Long id, Produto produto) {
        findById(id);
        produto.setId(id);
        return entityManager.merge(produto);
    }

}
