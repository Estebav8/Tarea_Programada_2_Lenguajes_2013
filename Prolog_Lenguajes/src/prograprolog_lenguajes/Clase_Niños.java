/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package prograprolog_lenguajes;
import java.util.ArrayList;
import jpl.Query;
import jpl.fli.Prolog;

/**
 *
 * @author jeny
 */

public class Clase_Niños {
    public ArrayList<String> Lista_Niños = new ArrayList<String>();
    private Prolog engine;
	private int lastid = 0;
	
	/**
	 * Constructor encargado de crear el engine/core de prolog
	 */
	public Clase_Niños(){
		this.engine = new Prolog();
		this.lastid = 0;
	}
 public void agregarNiño(String nombre,int edad, String pais, ArrayList Buenas_Acciones , ArrayList Malas_Acciones, ArrayList Wishlist, int Presupuesto ) {
        boolean add = Lista_Niños.add(nombre);
     int newid = this.lastid+1;
		try{
			
			String q = "niño("+nombre+","+edad+","+pais+","+Buenas_Acciones+","+Malas_Acciones+","+Wishlist+","+Presupuesto+").";
			System.out.println("QUERY_INSERT > " + q);
			Query t = new Query(q);
                        String tl = "consult('Consultas_Santa.pl')";
			
		}/* catch(InvalidTheoryException e) {
			System.out.println("ERROR > No se pudo agregar el nuevo niño");
			e.printStackTrace();
		}*/ catch(Exception er) {
		}
		System.out.println("Se agrego el niño " + nombre + " a la base de conocimiento");
		this.lastid++;
 }
}
    

