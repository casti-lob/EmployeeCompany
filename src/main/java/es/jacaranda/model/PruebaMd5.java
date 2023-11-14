package es.jacaranda.model;

import org.apache.commons.codec.digest.DigestUtils;

public class PruebaMd5 {
 
	public static void main (String[] args) {
		String cadenaEncriptada = DigestUtils.md5Hex("jose");
		System.out.println(cadenaEncriptada);
	}
}
