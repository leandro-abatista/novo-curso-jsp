package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnectionBanco {
	
	private static String banco = "jdbc:postgresql://localhost:5432/db_novo-curso-jsp?autoReconnect=true";
	private static String user = "postgres";
	private static String password = "123";
	private static Connection connection = null;
	
	static {
		conectar();
	}
	
	public SingleConnectionBanco() {/*quando tiver uma inst�ncia, vai conectar*/
		conectar();
	}
	
	private static void conectar() {
		try {
			
			if (connection == null) {
				Class.forName("org.postgressql.Driver");/*Carrega o driver de conex�o do banco de dados*/
				connection = DriverManager.getConnection(banco, user, password);
				connection.setAutoCommit(false);/*para n�o efetuar alterara��es no banco sem autoriza��o*/
			}
			
		} catch (Exception e) {
			e.printStackTrace();/*mostra qualquer erro na hora de conectar*/
		}
	}
	
	public static Connection getConnection() {
		return connection;
	}
}
