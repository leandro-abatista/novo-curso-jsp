package servlets;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOProdutoRepository;
import model.Produto;

@WebServlet("/ServletProdutoController")
public class ServletProduto extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private DAOProdutoRepository produtoRepository = new DAOProdutoRepository();

	public ServletProduto() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			
			String mensagem = null;
			
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listProduct")) {
				//CARREGA A LISTA DE PRODUTOS APÓS CARREGAR A PÁGINA DE PRODUTOS 
				List<Produto> produtos = produtoRepository.listaDeProdutosCadastrados();
				request.setAttribute("listaDeProdutos", produtos);
				
				//request.getRequestDispatcher("principal/cad_produto.jsp").forward(request, response);
				
			} else if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deleteProduct")) {
				
				String idProduto = request.getParameter("id");
				produtoRepository.deletarProduto(Long.parseLong(idProduto));
				
				//CARREGA A LISTA DE PRODUTOS APÓS CARREGAR A PÁGINA DE PRODUTOS 
				List<Produto> produtos = produtoRepository.listaDeProdutosCadastrados();
				request.setAttribute("listaDeProdutos", produtos);
				
				request.setAttribute("mensagem", "Produto excluído com sucesso!");
				
			} else if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("editProduct")) {
				
				String idProduto = request.getParameter("id");
				Produto produtoEmEdicao = produtoRepository.consultarProdutoPorId(Long.parseLong(idProduto));
				
				//CARREGA A LISTA DE PRODUTOS APÓS CARREGAR A PÁGINA DE PRODUTOS 
				List<Produto> produtos = produtoRepository.listaDeProdutosCadastrados();
				request.setAttribute("listaDeProdutos", produtos);
				
				request.setAttribute("mensagem", "Produto em edição!");
				request.setAttribute("produto", produtoEmEdicao);
				
			} else if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("searchProductAjax")) {
				
				//PARÂMETRO DE BUSCA QUE VEM DA PÁGINA, LÁ DO MODAL
				String descricaoBuscaAjax = request.getParameter("descricaoBuscaAjax");
				
				//dadosEmJsonDoProduto -> RECEBE UMA LISTA DE PRODUTOS ATRAVÉS DA CONSULTA NO BANCO DE DADOS
				List<Produto> listProducts = produtoRepository
						.consultarListaDeProdutosPorDescricao(descricaoBuscaAjax);
				
				ObjectMapper objectMapper = new ObjectMapper();
				
				String dadosProdutoEmJson = objectMapper.writeValueAsString(listProducts);
				
				//RESPOSTA PARA A TELA EM JSON
				response.getWriter().write(dadosProdutoEmJson);
				
				
			}
			
			
			request.getRequestDispatcher("principal/cad_produto.jsp").forward(request, response);
			
			} catch (Exception e) {
				e.printStackTrace();
				RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
				request.setAttribute("msg", e.getMessage());
				redirecionar.forward(request, response);
			}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String mensagem = null;

		try {

			String id = request.getParameter("id");
			String descricao = request.getParameter("descricao");
			String quantidade = request.getParameter("quantidade");
			String dataEntrada = request.getParameter("dataEntrada");
			String unidadeMedida = request.getParameter("unidademedida");

			Produto produto = new Produto();
			produto.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			produto.setDescricao(descricao);
			produto.setQuantidade(Integer.valueOf(quantidade));
			produto.setDataEntrada(Date.valueOf(dataEntrada));
			produto.setUnidadeMedida(unidadeMedida);
			
			
			if (produtoRepository.validarProdutoPelaDescricao(produto.getDescricao()) && produto.getId() == null) {
				mensagem = "Este produto já está cadastrado!";
			} else {
				if (produto.isProdutoNovo()) {
					mensagem = "Produto cadastrado com sucesso!";
				}
				
				produto = produtoRepository.gravarProduto(produto);
			}
			
			List<Produto> produtos = produtoRepository.listaDeProdutosCadastrados();
			request.setAttribute("listaDeProdutos", produtos);
			
			request.setAttribute("mensagem", mensagem);
			request.setAttribute("produto", produto);
			RequestDispatcher redirecionaAPagina = request.getRequestDispatcher("principal/cad_produto.jsp");
			redirecionaAPagina.forward(request, response);
			//SETA O OBJETO NA TELA
			request.setAttribute("produto", produto);
			
			

		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}
	}

}
