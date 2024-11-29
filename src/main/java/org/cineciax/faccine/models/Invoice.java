package org.cineciax.faccine.models;
import java.util.List;

public class Invoice {
    private String tipOperacion;
    private String fecEmision;//"YYYY-MM-DD"
    private String horEmision;//"HH:MM:SS"
    private String fecVencimiento;//"YYYY-MM-DD"
    private String codLocalEmisor;
    private String tipDocUsuario;
    private String numDocUsuario;
    private String rznSocialUsuario;
    private String tipMoneda;
    private double sumTotTributos;
    private double sumTotValVenta;
    private double sumPrecioVenta;
    private double sumDescTotal;
    private double sumOtrosCargos;
    private double sumTotalAnticipos;
    private double sumImpVenta;
    private String ublVersionId;
    private String customizationId;
    private List<DocumentDetail> detalle;
}
