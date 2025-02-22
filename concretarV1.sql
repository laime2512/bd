PGDMP     :    &                 y         
   cocretardb    13.1    13.1 ;   L           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            M           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            N           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            O           1262    18643 
   cocretardb    DATABASE     g   CREATE DATABASE cocretardb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Mexico.1252';
    DROP DATABASE cocretardb;
                postgres    false            �            1255    18644 @   calcular_cantidad(integer, character, integer, double precision)    FUNCTION     �  CREATE FUNCTION public.calcular_cantidad(p_cantidad integer, p_tipo character, p_unixcaja integer, p_unixpaquete double precision) RETURNS double precision
    LANGUAGE plpgsql
    AS $$BEGIN
	if(p_tipo = '2')then
		return cast(p_cantidad as float) / cast(p_unixcaja as float);
	end if;
	if(p_tipo = '3')then
		return cast(p_cantidad as float) / cast(p_unixcaja as float) / p_unixpaquete;
	end if;
	if(p_tipo = '1')then
		return p_cantidad;
	end if;
	RETURN -1;
END
$$;
 �   DROP FUNCTION public.calcular_cantidad(p_cantidad integer, p_tipo character, p_unixcaja integer, p_unixpaquete double precision);
       public          postgres    false            �            1255    18645    tipo_cantidad(character)    FUNCTION     9  CREATE FUNCTION public.tipo_cantidad(p_tipo character) RETURNS character varying
    LANGUAGE plpgsql
    AS $$BEGIN
	if(p_tipo = '1') then
		RETURN 'Unidades';
	end if;
		if(p_tipo = '2') then
		RETURN 'Cajas';
		end if;
		if(p_tipo = '3') then
		RETURN 'Paquetes';
		end if;
		RETURN 'not';
END
$$;
 6   DROP FUNCTION public.tipo_cantidad(p_tipo character);
       public          postgres    false            �            1259    18646    acceso_sucursal    TABLE     �   CREATE TABLE public.acceso_sucursal (
    codusu bigint NOT NULL,
    codsuc integer NOT NULL,
    fecalta timestamp without time zone NOT NULL,
    fecbaja timestamp without time zone
);
 #   DROP TABLE public.acceso_sucursal;
       public         heap    postgres    false            �            1259    18649    accesousuario    TABLE     �   CREATE TABLE public.accesousuario (
    login character varying(150) NOT NULL,
    passwd character varying(200) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codusu bigint NOT NULL
);
 !   DROP TABLE public.accesousuario;
       public         heap    postgres    false            P           0    0    COLUMN accesousuario.login    COMMENT     Z   COMMENT ON COLUMN public.accesousuario.login IS 'nombre del usuario o login del usuario';
          public          postgres    false    201            Q           0    0    COLUMN accesousuario.passwd    COMMENT     O   COMMENT ON COLUMN public.accesousuario.passwd IS 'clave de acceso al usuario';
          public          postgres    false    201            R           0    0    COLUMN accesousuario.estado    COMMENT     H   COMMENT ON COLUMN public.accesousuario.estado IS '1=activo, 0=anulado';
          public          postgres    false    201            S           0    0    COLUMN accesousuario.codusu    COMMENT     N   COMMENT ON COLUMN public.accesousuario.codusu IS 'referencia tabla usuarios';
          public          postgres    false    201            �            1259    18653    almacen    TABLE     }   CREATE TABLE public.almacen (
    codlugar bigint NOT NULL,
    cantidad integer NOT NULL,
    codalmacen bigint NOT NULL
);
    DROP TABLE public.almacen;
       public         heap    postgres    false            �            1259    18656    area    TABLE     �   CREATE TABLE public.area (
    codare integer NOT NULL,
    nombre character varying(100) NOT NULL,
    estado boolean NOT NULL
);
    DROP TABLE public.area;
       public         heap    postgres    false            �            1259    18659    backup    TABLE     �   CREATE TABLE public.backup (
    cod bigint NOT NULL,
    xuser character varying(250) NOT NULL,
    descripcion character varying(500) NOT NULL
);
    DROP TABLE public.backup;
       public         heap    postgres    false            �            1259    18665    caja    TABLE     i  CREATE TABLE public.caja (
    codcaja bigint NOT NULL,
    codusu bigint NOT NULL,
    fini timestamp(6) without time zone NOT NULL,
    ffin timestamp(6) without time zone,
    monini real NOT NULL,
    monfin real,
    monsistema real,
    estado smallint DEFAULT 1 NOT NULL,
    codsuc integer,
    observacion character varying(1500),
    tipo smallint
);
    DROP TABLE public.caja;
       public         heap    postgres    false            T           0    0    COLUMN caja.codcaja    COMMENT     ;   COMMENT ON COLUMN public.caja.codcaja IS 'codigo de caja';
          public          postgres    false    205            U           0    0    COLUMN caja.codusu    COMMENT     E   COMMENT ON COLUMN public.caja.codusu IS 'referencia tabal usuarios';
          public          postgres    false    205            V           0    0    COLUMN caja.fini    COMMENT     D   COMMENT ON COLUMN public.caja.fini IS 'fecha de inicio de la caja';
          public          postgres    false    205            W           0    0    COLUMN caja.ffin    COMMENT     >   COMMENT ON COLUMN public.caja.ffin IS 'fecha fin de la caja';
          public          postgres    false    205            X           0    0    COLUMN caja.monini    COMMENT     D   COMMENT ON COLUMN public.caja.monini IS 'monto inicial de la caja';
          public          postgres    false    205            Y           0    0    COLUMN caja.monfin    COMMENT     B   COMMENT ON COLUMN public.caja.monfin IS 'monto final de la caja';
          public          postgres    false    205            Z           0    0    COLUMN caja.monsistema    COMMENT     B   COMMENT ON COLUMN public.caja.monsistema IS 'monto del sistema ';
          public          postgres    false    205            [           0    0    COLUMN caja.estado    COMMENT     ?   COMMENT ON COLUMN public.caja.estado IS '1=activo, 0=anulado';
          public          postgres    false    205            \           0    0    COLUMN caja.tipo    COMMENT     @   COMMENT ON COLUMN public.caja.tipo IS '1=activo, 2=finalizado';
          public          postgres    false    205            �            1259    18672 	   categoria    TABLE     �   CREATE TABLE public.categoria (
    codcat smallint NOT NULL,
    nomcat character varying(500) NOT NULL,
    estado smallint NOT NULL
);
    DROP TABLE public.categoria;
       public         heap    postgres    false            ]           0    0    COLUMN categoria.codcat    COMMENT     D   COMMENT ON COLUMN public.categoria.codcat IS 'codigo de categoria';
          public          postgres    false    206            ^           0    0    COLUMN categoria.nomcat    COMMENT     G   COMMENT ON COLUMN public.categoria.nomcat IS 'nombre de la categoria';
          public          postgres    false    206            _           0    0    COLUMN categoria.estado    COMMENT     D   COMMENT ON COLUMN public.categoria.estado IS '1=activo, 0=anulado';
          public          postgres    false    206            �            1259    18678    cliente    TABLE     �   CREATE TABLE public.cliente (
    estado smallint DEFAULT 1 NOT NULL,
    nit character varying(15),
    direccion character varying(255),
    celular character varying(15),
    codcli bigint NOT NULL,
    razon_nit character varying(250)
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            `           0    0    COLUMN cliente.estado    COMMENT     B   COMMENT ON COLUMN public.cliente.estado IS '1=activo, 0=anulado';
          public          postgres    false    207            a           0    0    COLUMN cliente.nit    COMMENT     ;   COMMENT ON COLUMN public.cliente.nit IS 'nit del cliente';
          public          postgres    false    207            b           0    0    COLUMN cliente.direccion    COMMENT     G   COMMENT ON COLUMN public.cliente.direccion IS 'direccion del cliente';
          public          postgres    false    207            c           0    0    COLUMN cliente.celular    COMMENT     C   COMMENT ON COLUMN public.cliente.celular IS 'celular del cliente';
          public          postgres    false    207            d           0    0    COLUMN cliente.codcli    COMMENT     A   COMMENT ON COLUMN public.cliente.codcli IS 'codigo del cliente';
          public          postgres    false    207            �            1259    18685    compra    TABLE     	  CREATE TABLE public.compra (
    codcom bigint NOT NULL,
    fecha timestamp(0) without time zone NOT NULL,
    estado smallint DEFAULT 1,
    codusu bigint NOT NULL,
    codpro bigint NOT NULL,
    tiponota smallint DEFAULT 1 NOT NULL,
    total real NOT NULL,
    descuento real,
    codcaja bigint,
    coddetcaja bigint,
    num bigint NOT NULL,
    formapago integer,
    bonificacion real,
    subtotal real,
    numnota character varying(50),
    codsuc integer,
    credito boolean,
    estado_credito boolean
);
    DROP TABLE public.compra;
       public         heap    postgres    false            e           0    0    COLUMN compra.codcom    COMMENT     ?   COMMENT ON COLUMN public.compra.codcom IS 'codigo de compra ';
          public          postgres    false    208            f           0    0    COLUMN compra.fecha    COMMENT     ?   COMMENT ON COLUMN public.compra.fecha IS 'fecha de la compra';
          public          postgres    false    208            g           0    0    COLUMN compra.estado    COMMENT     A   COMMENT ON COLUMN public.compra.estado IS '1=activo, 0=anulado';
          public          postgres    false    208            h           0    0    COLUMN compra.codusu    COMMENT     G   COMMENT ON COLUMN public.compra.codusu IS 'referencia tabla usuarios';
          public          postgres    false    208            i           0    0    COLUMN compra.codpro    COMMENT     G   COMMENT ON COLUMN public.compra.codpro IS 'referencia tabla producto';
          public          postgres    false    208            j           0    0    COLUMN compra.tiponota    COMMENT     ]   COMMENT ON COLUMN public.compra.tiponota IS 'tipo de compra 1 = nota de venta y 2 =factura';
          public          postgres    false    208            k           0    0    COLUMN compra.total    COMMENT     ?   COMMENT ON COLUMN public.compra.total IS 'total de la compra';
          public          postgres    false    208            l           0    0    COLUMN compra.descuento    COMMENT     Q   COMMENT ON COLUMN public.compra.descuento IS 'descuento especiald de la compra';
          public          postgres    false    208            m           0    0    COLUMN compra.formapago    COMMENT     H   COMMENT ON COLUMN public.compra.formapago IS 'con dinero, con tarjeta';
          public          postgres    false    208            n           0    0    COLUMN compra.credito    COMMENT     D   COMMENT ON COLUMN public.compra.credito IS 'true = si, false = no';
          public          postgres    false    208            o           0    0    COLUMN compra.estado_credito    COMMENT     Z   COMMENT ON COLUMN public.compra.estado_credito IS 'true = pendiente, false = finalizado';
          public          postgres    false    208            �            1259    18690    cuenta    TABLE     �   CREATE TABLE public.cuenta (
    codcuenta integer NOT NULL,
    nombre character varying(150) NOT NULL,
    estado boolean NOT NULL,
    tipo boolean NOT NULL
);
    DROP TABLE public.cuenta;
       public         heap    postgres    false            p           0    0    COLUMN cuenta.estado    COMMENT     E   COMMENT ON COLUMN public.cuenta.estado IS 'true= debe, false=haber';
          public          postgres    false    209            �            1259    18693    detalle_margen    TABLE     �   CREATE TABLE public.detalle_margen (
    cod_margen integer NOT NULL,
    number_margin smallint NOT NULL,
    concept character varying(500) NOT NULL,
    type_margin character varying(50) NOT NULL,
    porcentaje_unidad real NOT NULL
);
 "   DROP TABLE public.detalle_margen;
       public         heap    postgres    false            q           0    0    TABLE detalle_margen    COMMENT     =   COMMENT ON TABLE public.detalle_margen IS 'Tabla de margen';
          public          postgres    false    210            �            1259    18699    detalle_salida    TABLE     �   CREATE TABLE public.detalle_salida (
    codsal bigint NOT NULL,
    codalmacen bigint NOT NULL,
    cantidad integer NOT NULL,
    fingreso date,
    fvencimiento date,
    in_out boolean DEFAULT false,
    is_response boolean
);
 "   DROP TABLE public.detalle_salida;
       public         heap    postgres    false            �            1259    18703    detallecaja    TABLE     �   CREATE TABLE public.detallecaja (
    codcaja bigint NOT NULL,
    coddetcaja bigint NOT NULL,
    monto real NOT NULL,
    fecha timestamp(6) without time zone NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codcuenta integer
);
    DROP TABLE public.detallecaja;
       public         heap    postgres    false            r           0    0    COLUMN detallecaja.codcaja    COMMENT     I   COMMENT ON COLUMN public.detallecaja.codcaja IS 'referencia tabla caja';
          public          postgres    false    212            s           0    0    COLUMN detallecaja.coddetcaja    COMMENT     P   COMMENT ON COLUMN public.detallecaja.coddetcaja IS 'codigo de detalle de caja';
          public          postgres    false    212            t           0    0    COLUMN detallecaja.monto    COMMENT     B   COMMENT ON COLUMN public.detallecaja.monto IS 'monto de la caja';
          public          postgres    false    212            u           0    0    COLUMN detallecaja.fecha    COMMENT     B   COMMENT ON COLUMN public.detallecaja.fecha IS 'fecha de la caja';
          public          postgres    false    212            v           0    0    COLUMN detallecaja.estado    COMMENT     B   COMMENT ON COLUMN public.detallecaja.estado IS '1=debe, 0=haber';
          public          postgres    false    212            �            1259    18707    detallecompra    TABLE     �  CREATE TABLE public.detallecompra (
    codcom bigint NOT NULL,
    codpro bigint,
    cantidad smallint NOT NULL,
    precio real NOT NULL,
    subtotal real NOT NULL,
    fingreso date,
    fvencimiento date,
    codalmacen bigint,
    coddcom integer NOT NULL,
    impuestos real,
    devolucion boolean,
    descuento real,
    porcentaje_unidad real,
    porcentaje_caja real,
    porcentaje_paquete real,
    tipo_compra character(1)
);
 !   DROP TABLE public.detallecompra;
       public         heap    postgres    false            w           0    0    COLUMN detallecompra.codcom    COMMENT     Q   COMMENT ON COLUMN public.detallecompra.codcom IS 'referencia a la tabla compra';
          public          postgres    false    213            x           0    0    COLUMN detallecompra.codpro    COMMENT     S   COMMENT ON COLUMN public.detallecompra.codpro IS 'referencia a la tabla producto';
          public          postgres    false    213            y           0    0    COLUMN detallecompra.cantidad    COMMENT     K   COMMENT ON COLUMN public.detallecompra.cantidad IS 'cantidad de producto';
          public          postgres    false    213            z           0    0    COLUMN detallecompra.precio    COMMENT     G   COMMENT ON COLUMN public.detallecompra.precio IS 'precio de producto';
          public          postgres    false    213            {           0    0    COLUMN detallecompra.subtotal    COMMENT     ?   COMMENT ON COLUMN public.detallecompra.subtotal IS 'subtotal';
          public          postgres    false    213            |           0    0    COLUMN detallecompra.fingreso    COMMENT     G   COMMENT ON COLUMN public.detallecompra.fingreso IS 'fecha de ingreso';
          public          postgres    false    213            }           0    0 !   COLUMN detallecompra.fvencimiento    COMMENT     O   COMMENT ON COLUMN public.detallecompra.fvencimiento IS 'fecha de vencimiento';
          public          postgres    false    213            ~           0    0    COLUMN detallecompra.codalmacen    COMMENT     G   COMMENT ON COLUMN public.detallecompra.codalmacen IS 'codigo almacen';
          public          postgres    false    213                       0    0    COLUMN detallecompra.coddcom    COMMENT     N   COMMENT ON COLUMN public.detallecompra.coddcom IS 'codigo detalle de compra';
          public          postgres    false    213            �           0    0     COLUMN detallecompra.tipo_compra    COMMENT     v   COMMENT ON COLUMN public.detallecompra.tipo_compra IS '1=compra por unidad, 2=compra por caja, 3=compra por paquete';
          public          postgres    false    213            �            1259    18710    detallepedido    TABLE     �   CREATE TABLE public.detallepedido (
    codped bigint NOT NULL,
    codpro bigint NOT NULL,
    cantidad integer NOT NULL,
    precio real NOT NULL,
    subtotal real NOT NULL
);
 !   DROP TABLE public.detallepedido;
       public         heap    postgres    false            �            1259    18713    detallepromo    TABLE     �   CREATE TABLE public.detallepromo (
    codpromo bigint NOT NULL,
    codpro bigint NOT NULL,
    descuento_unidad real NOT NULL,
    descuento_caja real,
    descuento_paquete real
);
     DROP TABLE public.detallepromo;
       public         heap    postgres    false            �            1259    18716    detalleventa    TABLE     �   CREATE TABLE public.detalleventa (
    codpro bigint NOT NULL,
    cantidad integer NOT NULL,
    codven bigint NOT NULL,
    precio real NOT NULL,
    subtotal real,
    codalmacen bigint NOT NULL,
    tipo_venta character(1),
    codpromo bigint
);
     DROP TABLE public.detalleventa;
       public         heap    postgres    false            �           0    0    COLUMN detalleventa.codpro    COMMENT     R   COMMENT ON COLUMN public.detalleventa.codpro IS 'referencia a la tabla producto';
          public          postgres    false    216            �           0    0    COLUMN detalleventa.cantidad    COMMENT     K   COMMENT ON COLUMN public.detalleventa.cantidad IS 'cantidad del producto';
          public          postgres    false    216            �           0    0    COLUMN detalleventa.codven    COMMENT     O   COMMENT ON COLUMN public.detalleventa.codven IS 'referencia a la tabla venta';
          public          postgres    false    216            �           0    0    COLUMN detalleventa.precio    COMMENT     G   COMMENT ON COLUMN public.detalleventa.precio IS 'precio del producto';
          public          postgres    false    216            �           0    0    COLUMN detalleventa.subtotal    COMMENT     ?   COMMENT ON COLUMN public.detalleventa.subtotal IS 'subtotal ';
          public          postgres    false    216            �            1259    18719    dosificacion    TABLE     �  CREATE TABLE public.dosificacion (
    coddosificacion integer NOT NULL,
    razonsocial character varying(500) NOT NULL,
    direccion character varying(1000) NOT NULL,
    telefono character varying(200) NOT NULL,
    lugar character varying(400) NOT NULL,
    nit character varying(100) NOT NULL,
    numaut character varying(50) NOT NULL,
    actividad character varying(500) NOT NULL,
    llave character varying(500) NOT NULL,
    leyenda character varying(500) NOT NULL,
    mensaje character varying(500) NOT NULL,
    flimite date NOT NULL,
    ftramite date,
    numtramite character varying(50),
    sfc character varying(1000),
    est integer NOT NULL,
    codsuc integer,
    sigla character varying(25),
    numinifac integer,
    numfinfac integer
);
     DROP TABLE public.dosificacion;
       public         heap    postgres    false            �           0    0    COLUMN dosificacion.est    COMMENT     S   COMMENT ON COLUMN public.dosificacion.est IS '0:eliminado, 1:activo,2=finalizado';
          public          postgres    false    217            �            1259    18725    factura    TABLE     |  CREATE TABLE public.factura (
    coddosificacion integer NOT NULL,
    numfac integer NOT NULL,
    fecfac timestamp(6) without time zone NOT NULL,
    nitfac character varying(100) NOT NULL,
    codcontrol character varying(100) NOT NULL,
    estado character varying(30) NOT NULL,
    cliente_nit character varying(255),
    codven bigint,
    codcom bigint,
    total real
);
    DROP TABLE public.factura;
       public         heap    postgres    false            �           0    0    COLUMN factura.coddosificacion    COMMENT     N   COMMENT ON COLUMN public.factura.coddosificacion IS 'codigo de dosificacion';
          public          postgres    false    218            �           0    0    COLUMN factura.numfac    COMMENT     C   COMMENT ON COLUMN public.factura.numfac IS 'numero de la factura';
          public          postgres    false    218            �           0    0    COLUMN factura.fecfac    COMMENT     B   COMMENT ON COLUMN public.factura.fecfac IS 'fecha de la factura';
          public          postgres    false    218            �           0    0    COLUMN factura.nitfac    COMMENT     @   COMMENT ON COLUMN public.factura.nitfac IS 'nit de la factura';
          public          postgres    false    218            �           0    0    COLUMN factura.codcontrol    COMMENT     D   COMMENT ON COLUMN public.factura.codcontrol IS 'codigo de control';
          public          postgres    false    218            �           0    0    COLUMN factura.estado    COMMENT     B   COMMENT ON COLUMN public.factura.estado IS '1=activo, 0=anulado';
          public          postgres    false    218            �            1259    18728    laboratorio    TABLE     �   CREATE TABLE public.laboratorio (
    codlab integer NOT NULL,
    nombre character varying(250) NOT NULL,
    estado boolean DEFAULT true NOT NULL
);
    DROP TABLE public.laboratorio;
       public         heap    postgres    false            �            1259    18732    lugar    TABLE     �   CREATE TABLE public.lugar (
    codsuc integer NOT NULL,
    codpro bigint NOT NULL,
    codposicion integer NOT NULL,
    codlugar bigint NOT NULL
);
    DROP TABLE public.lugar;
       public         heap    postgres    false            �            1259    18735    margen    TABLE     �   CREATE TABLE public.margen (
    cod_margen integer NOT NULL,
    codusu bigint NOT NULL,
    date_register timestamp without time zone NOT NULL,
    observacion character varying(500) NOT NULL,
    estado boolean DEFAULT true NOT NULL
);
    DROP TABLE public.margen;
       public         heap    postgres    false            �            1259    18742    medida    TABLE     �   CREATE TABLE public.medida (
    codmed integer NOT NULL,
    nombre character varying(50) NOT NULL,
    estado boolean NOT NULL
);
    DROP TABLE public.medida;
       public         heap    postgres    false            �            1259    18745    menu    TABLE     �   CREATE TABLE public.menu (
    codm integer NOT NULL,
    nombre character varying(40) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL
);
    DROP TABLE public.menu;
       public         heap    postgres    false            �           0    0    COLUMN menu.codm    COMMENT     9   COMMENT ON COLUMN public.menu.codm IS 'codigo del menu';
          public          postgres    false    223            �           0    0    COLUMN menu.nombre    COMMENT     ;   COMMENT ON COLUMN public.menu.nombre IS 'nombre del menu';
          public          postgres    false    223            �           0    0    COLUMN menu.estado    COMMENT     ?   COMMENT ON COLUMN public.menu.estado IS '1=activo, 0=anulado';
          public          postgres    false    223            �            1259    18749    mepro    TABLE     T   CREATE TABLE public.mepro (
    codm integer NOT NULL,
    codp integer NOT NULL
);
    DROP TABLE public.mepro;
       public         heap    postgres    false            �           0    0    COLUMN mepro.codm    COMMENT     @   COMMENT ON COLUMN public.mepro.codm IS 'referencia tabla menu';
          public          postgres    false    224            �           0    0    COLUMN mepro.codp    COMMENT     D   COMMENT ON COLUMN public.mepro.codp IS 'referencia tabla procesos';
          public          postgres    false    224            �            1259    18752    mueble    TABLE     �   CREATE TABLE public.mueble (
    codmueble integer NOT NULL,
    nombre character varying(255) NOT NULL,
    estado smallint DEFAULT 1,
    codtimu integer
);
    DROP TABLE public.mueble;
       public         heap    postgres    false            �           0    0    COLUMN mueble.codmueble    COMMENT     A   COMMENT ON COLUMN public.mueble.codmueble IS 'codigo de mueble';
          public          postgres    false    225            �           0    0    COLUMN mueble.nombre    COMMENT     >   COMMENT ON COLUMN public.mueble.nombre IS 'nombre de mueble';
          public          postgres    false    225            �            1259    18756    pagocredito    TABLE     �   CREATE TABLE public.pagocredito (
    codcom bigint NOT NULL,
    fecha date NOT NULL,
    fecreg timestamp(6) without time zone NOT NULL,
    monto real NOT NULL,
    codusu bigint NOT NULL,
    observacion character varying(500)
);
    DROP TABLE public.pagocredito;
       public         heap    postgres    false            �            1259    18762    pedido    TABLE     �  CREATE TABLE public.pedido (
    codped bigint NOT NULL,
    fecha timestamp(6) without time zone NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codusu bigint NOT NULL,
    celular character varying(15) NOT NULL,
    direccion character varying(255),
    observacion character varying(500),
    fentrega timestamp(6) without time zone,
    coddelivery integer,
    nit character varying(25),
    razon_nit character varying(250),
    codven bigint,
    codsuc integer
);
    DROP TABLE public.pedido;
       public         heap    postgres    false            �            1259    18769    posicion    TABLE     �   CREATE TABLE public.posicion (
    codposicion integer NOT NULL,
    nombre character varying(255) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codmueble integer
);
    DROP TABLE public.posicion;
       public         heap    postgres    false            �           0    0    COLUMN posicion.codposicion    COMMENT     H   COMMENT ON COLUMN public.posicion.codposicion IS 'codigo de posicion ';
          public          postgres    false    228            �           0    0    COLUMN posicion.nombre    COMMENT     B   COMMENT ON COLUMN public.posicion.nombre IS 'nombre de posicion';
          public          postgres    false    228            �           0    0    COLUMN posicion.estado    COMMENT     C   COMMENT ON COLUMN public.posicion.estado IS '1=activo, 0=anulado';
          public          postgres    false    228            �            1259    18773    presentacion    TABLE     �   CREATE TABLE public.presentacion (
    codpre integer NOT NULL,
    nombre character varying NOT NULL,
    estado boolean NOT NULL
);
     DROP TABLE public.presentacion;
       public         heap    postgres    false            �            1259    18779    proceso    TABLE     �   CREATE TABLE public.proceso (
    codp integer NOT NULL,
    nombre character varying(40) NOT NULL,
    enlace character varying(60) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL
);
    DROP TABLE public.proceso;
       public         heap    postgres    false            �           0    0    COLUMN proceso.codp    COMMENT     ?   COMMENT ON COLUMN public.proceso.codp IS 'codigo de procesos';
          public          postgres    false    230            �           0    0    COLUMN proceso.nombre    COMMENT     A   COMMENT ON COLUMN public.proceso.nombre IS 'nombre del proceso';
          public          postgres    false    230            �           0    0    COLUMN proceso.enlace    COMMENT     H   COMMENT ON COLUMN public.proceso.enlace IS 'link o enlace del proceso';
          public          postgres    false    230            �           0    0    COLUMN proceso.estado    COMMENT     B   COMMENT ON COLUMN public.proceso.estado IS '1=activo, 0=anulado';
          public          postgres    false    230            �            1259    18783    producto    TABLE     �  CREATE TABLE public.producto (
    codpro bigint NOT NULL,
    nombre character varying(150),
    estado smallint DEFAULT 1,
    foto character varying(40),
    codtip smallint,
    generico character varying(255),
    codigobarra character varying(30),
    codlab integer,
    concentracion character varying(25),
    codmed integer,
    codare integer,
    pc_unit real,
    pv_unit real,
    porcentaje_unidad real,
    codpre integer,
    controlado boolean DEFAULT false,
    inventario_minimo_unidad real,
    pareto character varying(25),
    unixcaja integer DEFAULT 0,
    pv_caja real,
    pv_descuento_caja real,
    pc_caja real,
    unixpaquete real,
    uni_en_paquete real,
    inventario_minimo_caja real,
    inventario_minimo_paquete real,
    pc_paquete real,
    pv_paquete real,
    porcentaje_caja real,
    porcentaje_paquete real,
    tipo_compra character(1),
    pv_descuento_paquete real,
    presentacion_unidad character varying(25),
    presentacion_caja character varying(25),
    presentacion_paquete character varying(25),
    margen character(1),
    porcentaje_descuento_caja real,
    porcentaje_descuento_paquete real
);
    DROP TABLE public.producto;
       public         heap    postgres    false            �           0    0    COLUMN producto.codpro    COMMENT     B   COMMENT ON COLUMN public.producto.codpro IS 'codigo de producto';
          public          postgres    false    231            �           0    0    COLUMN producto.nombre    COMMENT     B   COMMENT ON COLUMN public.producto.nombre IS 'nombre de producto';
          public          postgres    false    231            �           0    0    COLUMN producto.estado    COMMENT     C   COMMENT ON COLUMN public.producto.estado IS '1=activo, 0=anulado';
          public          postgres    false    231            �           0    0    COLUMN producto.foto    COMMENT     ?   COMMENT ON COLUMN public.producto.foto IS 'foto del producto';
          public          postgres    false    231            �           0    0    COLUMN producto.codtip    COMMENT     K   COMMENT ON COLUMN public.producto.codtip IS 'codigo del tipo de producto';
          public          postgres    false    231            �           0    0    COLUMN producto.generico    COMMENT     J   COMMENT ON COLUMN public.producto.generico IS 'composicion del producto';
          public          postgres    false    231            �           0    0    COLUMN producto.codigobarra    COMMENT     Q   COMMENT ON COLUMN public.producto.codigobarra IS 'codigo de barra del producto';
          public          postgres    false    231            �           0    0    COLUMN producto.codlab    COMMENT     E   COMMENT ON COLUMN public.producto.codlab IS 'codigo de laboratorio';
          public          postgres    false    231            �            1259    18792    producto_nuevo    TABLE     �   CREATE TABLE public.producto_nuevo (
    cod_pro_nuevo bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(300),
    estado boolean DEFAULT true NOT NULL,
    codusu bigint NOT NULL
);
 "   DROP TABLE public.producto_nuevo;
       public         heap    postgres    false            �            1259    18796 	   promocion    TABLE     :  CREATE TABLE public.promocion (
    codpromo bigint NOT NULL,
    fcreacion date NOT NULL,
    fini date NOT NULL,
    ffin date NOT NULL,
    titulo character varying(100) NOT NULL,
    descripcion character varying(500),
    codusu bigint NOT NULL,
    estpromo boolean NOT NULL,
    gestion integer NOT NULL
);
    DROP TABLE public.promocion;
       public         heap    postgres    false            �            1259    18802 	   proveedor    TABLE       CREATE TABLE public.proveedor (
    codproveedor bigint NOT NULL,
    nombre character varying(40) NOT NULL,
    nit integer NOT NULL,
    direccion character varying(40) NOT NULL,
    telefono character varying(20) NOT NULL,
    estado smallint DEFAULT 1
);
    DROP TABLE public.proveedor;
       public         heap    postgres    false            �           0    0    COLUMN proveedor.codproveedor    COMMENT     J   COMMENT ON COLUMN public.proveedor.codproveedor IS 'codigo de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.nombre    COMMENT     D   COMMENT ON COLUMN public.proveedor.nombre IS 'nombre de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.nit    COMMENT     >   COMMENT ON COLUMN public.proveedor.nit IS 'nit de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.direccion    COMMENT     J   COMMENT ON COLUMN public.proveedor.direccion IS 'direccion de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.telefono    COMMENT     H   COMMENT ON COLUMN public.proveedor.telefono IS 'telefono de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.estado    COMMENT     D   COMMENT ON COLUMN public.proveedor.estado IS '1=activo, 0=anulado';
          public          postgres    false    234            �            1259    18806    rol    TABLE     �   CREATE TABLE public.rol (
    codr integer NOT NULL,
    nombre character varying(40) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    acceso_venta boolean DEFAULT false
);
    DROP TABLE public.rol;
       public         heap    postgres    false            �           0    0    COLUMN rol.codr    COMMENT     7   COMMENT ON COLUMN public.rol.codr IS 'codigo del rol';
          public          postgres    false    235            �           0    0    COLUMN rol.nombre    COMMENT     9   COMMENT ON COLUMN public.rol.nombre IS 'nombre del rol';
          public          postgres    false    235            �           0    0    COLUMN rol.estado    COMMENT     >   COMMENT ON COLUMN public.rol.estado IS '1=activo, 0=anulado';
          public          postgres    false    235            �           0    0    COLUMN rol.acceso_venta    COMMENT     g   COMMENT ON COLUMN public.rol.acceso_venta IS 'Ventas: true=acceso completo, false=acceso restringido';
          public          postgres    false    235            �            1259    18811    rolme    TABLE     T   CREATE TABLE public.rolme (
    codr integer NOT NULL,
    codm integer NOT NULL
);
    DROP TABLE public.rolme;
       public         heap    postgres    false            �           0    0    COLUMN rolme.codr    COMMENT     A   COMMENT ON COLUMN public.rolme.codr IS 'referencia tabla roles';
          public          postgres    false    236            �           0    0    COLUMN rolme.codm    COMMENT     @   COMMENT ON COLUMN public.rolme.codm IS 'referencia tabla menu';
          public          postgres    false    236            �            1259    18814    rolusu    TABLE     e   CREATE TABLE public.rolusu (
    codr integer NOT NULL,
    login character varying(150) NOT NULL
);
    DROP TABLE public.rolusu;
       public         heap    postgres    false            �           0    0    COLUMN rolusu.codr    COMMENT     B   COMMENT ON COLUMN public.rolusu.codr IS 'referencia tabla roles';
          public          postgres    false    237            �           0    0    COLUMN rolusu.login    COMMENT     I   COMMENT ON COLUMN public.rolusu.login IS 'refencia tabla accesousuario';
          public          postgres    false    237            �            1259    18817    salida    TABLE     |  CREATE TABLE public.salida (
    codsal bigint NOT NULL,
    fsalida date,
    codusu bigint,
    tipo smallint,
    descripcion character varying(500),
    estado character varying(1),
    est boolean,
    numero bigint NOT NULL,
    suc_origen integer,
    suc_destino integer,
    in_out boolean,
    solucion smallint,
    monto real,
    conclusion character varying(500)
);
    DROP TABLE public.salida;
       public         heap    postgres    false            �           0    0    COLUMN salida.tipo    COMMENT     J  COMMENT ON COLUMN public.salida.tipo IS '1= Productos en mal estado,
2= Salida a otra farmacia egreso,
3=Medicamentos vencidos,
4= Perdida de medicamentos,
5= Uso de farmacia,
6= Disminucion de medicamento por usuario
7=Aumento de medicamento por usuario
8=Entrada de medicamento
9=salida
10=entrada de otra farmacia
';
          public          postgres    false    238            �           0    0    COLUMN salida.estado    COMMENT     R   COMMENT ON COLUMN public.salida.estado IS 'p=pendiente
a=aceptado
r=rechazado';
          public          postgres    false    238            �           0    0    COLUMN salida.in_out    COMMENT     J   COMMENT ON COLUMN public.salida.in_out IS 'true= ingreso, false= salida';
          public          postgres    false    238            �           0    0    COLUMN salida.solucion    COMMENT     3   COMMENT ON COLUMN public.salida.solucion IS '1= ';
          public          postgres    false    238            �            1259    18823    sucursal    TABLE     �   CREATE TABLE public.sucursal (
    codsuc integer NOT NULL,
    nombre character varying(500) NOT NULL,
    telefono character varying(50) NOT NULL,
    estado boolean NOT NULL,
    direccion character varying(300)
);
    DROP TABLE public.sucursal;
       public         heap    postgres    false            �            1259    18829    tipo    TABLE     �   CREATE TABLE public.tipo (
    codtip smallint NOT NULL,
    nomtip character varying(500) NOT NULL,
    estado smallint NOT NULL,
    codcat smallint NOT NULL
);
    DROP TABLE public.tipo;
       public         heap    postgres    false            �           0    0    COLUMN tipo.codtip    COMMENT     :   COMMENT ON COLUMN public.tipo.codtip IS 'codigo de tipo';
          public          postgres    false    240            �           0    0    COLUMN tipo.nomtip    COMMENT     :   COMMENT ON COLUMN public.tipo.nomtip IS 'nombre de tipo';
          public          postgres    false    240            �           0    0    COLUMN tipo.estado    COMMENT     ?   COMMENT ON COLUMN public.tipo.estado IS '1=activo, 0=anulado';
          public          postgres    false    240            �           0    0    COLUMN tipo.codcat    COMMENT     K   COMMENT ON COLUMN public.tipo.codcat IS 'referencia a la tabla categoria';
          public          postgres    false    240            �            1259    18835    tipo_mueble    TABLE     �   CREATE TABLE public.tipo_mueble (
    codtimu integer NOT NULL,
    nombre character varying(100) NOT NULL,
    estado boolean NOT NULL
);
    DROP TABLE public.tipo_mueble;
       public         heap    postgres    false            �            1259    18838    usuario    TABLE     �  CREATE TABLE public.usuario (
    codusu bigint NOT NULL,
    nombre character varying(60) DEFAULT 1 NOT NULL,
    ap character varying(40),
    am character varying(40),
    genero character varying(1) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    tipoper character varying(1) NOT NULL,
    foto character varying(40),
    ci character varying(15),
    fnac date,
    ecivil character varying(20),
    alias character varying(25)
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �           0    0    COLUMN usuario.codusu    COMMENT     C   COMMENT ON COLUMN public.usuario.codusu IS 'codigo de la persona';
          public          postgres    false    242            �           0    0    COLUMN usuario.nombre    COMMENT     C   COMMENT ON COLUMN public.usuario.nombre IS 'nombre de la persona';
          public          postgres    false    242            �           0    0    COLUMN usuario.ap    COMMENT     ;   COMMENT ON COLUMN public.usuario.ap IS 'apellido paterno';
          public          postgres    false    242            �           0    0    COLUMN usuario.am    COMMENT     ;   COMMENT ON COLUMN public.usuario.am IS 'apellido materno';
          public          postgres    false    242            �           0    0    COLUMN usuario.genero    COMMENT     O   COMMENT ON COLUMN public.usuario.genero IS 'genero (f=femenino, m=masculino)';
          public          postgres    false    242            �           0    0    COLUMN usuario.estado    COMMENT     B   COMMENT ON COLUMN public.usuario.estado IS '1=activo, 0=anulado';
          public          postgres    false    242            �           0    0    COLUMN usuario.tipoper    COMMENT     K   COMMENT ON COLUMN public.usuario.tipoper IS 'a=administrativo, p=publico';
          public          postgres    false    242            �           0    0    COLUMN usuario.foto    COMMENT     ?   COMMENT ON COLUMN public.usuario.foto IS 'foto de la persona';
          public          postgres    false    242            �           0    0    COLUMN usuario.ci    COMMENT     ?   COMMENT ON COLUMN public.usuario.ci IS 'cedula de la persona';
          public          postgres    false    242            �            1259    18843    venta    TABLE     b  CREATE TABLE public.venta (
    codven bigint NOT NULL,
    fecha date NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codcli bigint NOT NULL,
    tiponota smallint,
    codcaja bigint NOT NULL,
    coddetcaja bigint NOT NULL,
    formapago smallint,
    total real,
    codusu bigint,
    total_pagado real,
    cambio real,
    codsuc integer
);
    DROP TABLE public.venta;
       public         heap    postgres    false            �           0    0    TABLE venta    COMMENT     G   COMMENT ON TABLE public.venta IS '1=pendiente,2=aceptado,3=rechazado';
          public          postgres    false    243            �           0    0    COLUMN venta.codven    COMMENT     <   COMMENT ON COLUMN public.venta.codven IS 'codigo de venta';
          public          postgres    false    243            �           0    0    COLUMN venta.fecha    COMMENT     =   COMMENT ON COLUMN public.venta.fecha IS 'fecha de creacion';
          public          postgres    false    243            �           0    0    COLUMN venta.estado    COMMENT     A   COMMENT ON COLUMN public.venta.estado IS 'estado 1=activo, 0
';
          public          postgres    false    243            �           0    0    COLUMN venta.codcli    COMMENT     >   COMMENT ON COLUMN public.venta.codcli IS 'codigo de cliente';
          public          postgres    false    243            �           0    0    COLUMN venta.tiponota    COMMENT     Q   COMMENT ON COLUMN public.venta.tiponota IS '1=pendiente,2=aceptado,3=rechazado';
          public          postgres    false    243            �           0    0    COLUMN venta.codcaja    COMMENT     C   COMMENT ON COLUMN public.venta.codcaja IS 'referencia tabla caja';
          public          postgres    false    243            �           0    0    COLUMN venta.coddetcaja    COMMENT     T   COMMENT ON COLUMN public.venta.coddetcaja IS 'refencia a la tabla detalle de caja';
          public          postgres    false    243            �           0    0    COLUMN venta.formapago    COMMENT     N   COMMENT ON COLUMN public.venta.formapago IS '1 = al contado, 2 = al credito';
          public          postgres    false    243            �            1259    18847    view_almacen    VIEW     N  CREATE VIEW public.view_almacen AS
 SELECT p.codpro,
    p.nombre,
    p.foto,
    p.codtip,
    p.generico,
    p.codigobarra,
    p.codlab,
    p.concentracion,
    p.codmed,
    p.codare,
    p.pc_unit,
    p.pv_unit,
    p.porcentaje_unidad,
    p.estado,
    p.controlado,
    p.inventario_minimo_unidad,
    p.pareto,
    p.unixcaja,
    p.pc_caja,
    p.pv_caja,
    p.pv_descuento_caja,
    p.unixpaquete,
    p.uni_en_paquete,
    p.inventario_minimo_caja,
    p.inventario_minimo_paquete,
    p.pc_paquete,
    p.pv_paquete,
    p.porcentaje_caja,
    p.porcentaje_paquete,
    p.tipo_compra,
    p.pv_descuento_paquete,
    p.presentacion_unidad,
    p.presentacion_caja,
    p.presentacion_paquete,
    p.margen,
    p.porcentaje_descuento_caja,
    p.porcentaje_descuento_paquete,
    t.nomtip AS xtipo,
    c.nomcat AS xcategoria,
    l.nombre AS xlaboratorio,
    a.nombre AS xarea,
    m.nombre AS xmedida,
    lugar.codsuc,
    sum(almacen.cantidad) AS cantidad
   FROM (((((((public.almacen
     JOIN public.lugar ON ((lugar.codlugar = almacen.codlugar)))
     JOIN public.producto p ON ((p.codpro = lugar.codpro)))
     JOIN public.tipo t ON ((t.codtip = p.codtip)))
     JOIN public.categoria c ON ((c.codcat = t.codcat)))
     JOIN public.laboratorio l ON ((l.codlab = p.codlab)))
     JOIN public.medida m ON ((m.codmed = p.codmed)))
     JOIN public.area a ON ((a.codare = p.codare)))
  GROUP BY p.codpro, p.nombre, p.foto, p.codtip, p.generico, p.codigobarra, p.codlab, p.concentracion, p.codmed, p.codare, p.pc_unit, p.pv_unit, p.porcentaje_unidad, p.estado, p.controlado, p.inventario_minimo_unidad, p.pareto, p.unixcaja, p.pc_caja, p.pv_caja, p.pv_descuento_caja, p.unixpaquete, p.uni_en_paquete, p.inventario_minimo_caja, p.inventario_minimo_paquete, p.pc_paquete, p.pv_paquete, p.porcentaje_caja, p.porcentaje_paquete, p.tipo_compra, p.pv_descuento_paquete, p.presentacion_unidad, p.presentacion_caja, p.presentacion_paquete, p.margen, p.porcentaje_descuento_caja, p.porcentaje_descuento_paquete, t.nomtip, c.nomcat, l.nombre, a.nombre, m.nombre, lugar.codsuc
 HAVING (sum(almacen.cantidad) > 0);
    DROP VIEW public.view_almacen;
       public          postgres    false    222    222    231    231    231    231    231    240    231    240    231    231    231    240    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    219    206    206    203    203    202    231    231    231    231    202    231    231    219    220    220    220            �            1259    18852    view_compra    VIEW     z  CREATE VIEW public.view_compra AS
 SELECT compra.codcom,
    compra.fecha,
    compra.estado,
    compra.codusu,
    compra.codpro,
    compra.tiponota,
    compra.total,
    compra.descuento,
    compra.codcaja,
    compra.coddetcaja,
    compra.num,
    compra.formapago,
    compra.bonificacion,
    compra.subtotal,
    compra.numnota,
    compra.codsuc,
    compra.credito,
    compra.estado_credito,
    concat(usuario.nombre, ' ', usuario.ap) AS xusuario,
    proveedor.nombre AS xproveedor,
    to_char(compra.fecha, 'dd/MM/yyyy'::text) AS xfecha,
    ( SELECT COALESCE(sum(pagocredito.monto), (0)::real) AS "coalesce"
           FROM public.pagocredito
          WHERE (pagocredito.codcom = compra.codcom)) AS acuenta
   FROM ((public.compra
     JOIN public.proveedor ON ((proveedor.codproveedor = compra.codpro)))
     JOIN public.usuario ON ((usuario.codusu = compra.codusu)));
    DROP VIEW public.view_compra;
       public          postgres    false    208    208    208    208    208    208    208    208    208    208    208    208    208    208    208    208    208    208    226    226    234    234    242    242    242            �            1259    18857    view_detalle_salida    VIEW     �  CREATE VIEW public.view_detalle_salida AS
 SELECT ds.codsal,
    ds.codalmacen,
    ds.cantidad,
    ds.fingreso,
    ds.fvencimiento,
    ds.is_response,
    ds.in_out,
    l.codlugar,
    p.codpro,
    concat(p.nombre, ' (', p.generico, ')') AS nombre,
    to_char((ds.fingreso)::timestamp with time zone, 'dd/MM/yy'::text) AS xfingreso,
    to_char((ds.fvencimiento)::timestamp with time zone, 'dd/MM/yy'::text) AS xfvencimiento
   FROM (((public.detalle_salida ds
     JOIN public.almacen a ON ((a.codalmacen = ds.codalmacen)))
     JOIN public.lugar l ON ((l.codlugar = a.codlugar)))
     JOIN public.producto p ON ((p.codpro = l.codpro)))
  ORDER BY ds.is_response;
 &   DROP VIEW public.view_detalle_salida;
       public          postgres    false    211    220    220    231    202    202    211    211    231    231    211    211    211    211            �            1259    18862    view_detalle_venta    VIEW     �  CREATE VIEW public.view_detalle_venta AS
 SELECT detalleventa.codpro,
    detalleventa.cantidad,
    detalleventa.codven,
    detalleventa.precio,
    detalleventa.subtotal,
    detalleventa.codalmacen,
    detalleventa.tipo_venta,
    detalleventa.codpromo,
    concat(tipo.nomtip, ' ', producto.nombre, ' (', producto.generico, ') ', producto.concentracion, ' ', medida.nombre) AS xproducto,
    producto.unixcaja,
    producto.unixpaquete,
    public.calcular_cantidad(detalleventa.cantidad, detalleventa.tipo_venta, producto.unixcaja, (producto.unixpaquete)::double precision) AS cantidad_tipo_venta,
    public.tipo_cantidad(detalleventa.tipo_venta) AS xtipo_venta
   FROM (((public.detalleventa
     JOIN public.producto ON ((producto.codpro = detalleventa.codpro)))
     JOIN public.medida ON ((medida.codmed = producto.codmed)))
     JOIN public.tipo ON ((tipo.codtip = producto.codtip)));
 %   DROP VIEW public.view_detalle_venta;
       public          postgres    false    216    216    216    216    216    216    251    240    240    231    231    231    231    231    231    231    231    222    222    216    216    250            �            1259    18867    view_producto    VIEW     �  CREATE VIEW public.view_producto AS
 SELECT p.codpro,
    p.nombre,
    p.estado,
    p.foto,
    p.codtip,
    p.generico,
    p.codigobarra,
    p.codlab,
    p.concentracion,
    p.codmed,
    p.codare,
    p.pc_unit,
    p.pv_unit,
    p.porcentaje_unidad,
    p.codpre,
    p.controlado,
    p.inventario_minimo_unidad,
    p.pareto,
    p.unixcaja,
    p.pv_caja,
    p.pv_descuento_caja,
    p.pc_caja,
    p.unixpaquete,
    p.uni_en_paquete,
    p.inventario_minimo_caja,
    p.inventario_minimo_paquete,
    p.pc_paquete,
    p.pv_paquete,
    p.porcentaje_caja,
    p.porcentaje_paquete,
    p.tipo_compra,
    p.pv_descuento_paquete,
    p.presentacion_unidad,
    p.presentacion_caja,
    p.presentacion_paquete,
    p.margen,
    p.porcentaje_descuento_caja,
    p.porcentaje_descuento_paquete,
    t.nomtip AS xtipo,
    c.nomcat AS xcategoria,
    l.nombre AS xlaboratorio,
    a.nombre AS xarea,
    m.nombre AS xmedida
   FROM (((((public.producto p
     JOIN public.tipo t ON ((t.codtip = p.codtip)))
     JOIN public.categoria c ON ((c.codcat = t.codcat)))
     JOIN public.laboratorio l ON ((l.codlab = p.codlab)))
     JOIN public.medida m ON ((m.codmed = p.codmed)))
     JOIN public.area a ON ((a.codare = p.codare)))
  WHERE (p.estado = 1);
     DROP VIEW public.view_producto;
       public          postgres    false    222    231    231    231    231    231    231    231    231    231    231    240    231    231    231    231    231    231    231    231    231    231    231    231    231    231    240    203    203    206    240    231    231    231    231    231    231    231    231    231    231    231    231    231    206    222    219    219    231            �            1259    18872 
   view_venta    VIEW       CREATE VIEW public.view_venta AS
 SELECT venta.codven,
    venta.fecha,
    venta.estado,
    venta.codcli,
    venta.tiponota,
    venta.codcaja,
    venta.coddetcaja,
    venta.formapago,
    venta.total,
    venta.codusu,
    venta.total_pagado,
    venta.cambio,
    venta.codsuc,
    to_char((venta.fecha)::timestamp with time zone, 'DD/MM/YY'::text) AS xfecha,
    concat(usuario.nombre, ' ', usuario.ap) AS xcliente,
    concat(u.nombre, ' ', u.ap) AS xusuario,
    ( SELECT count(*) AS facturado
           FROM public.factura factura_1
          WHERE ((factura_1.codven = venta.codven) AND ((factura_1.estado)::text = 'activo'::text))) AS facturado,
    factura.cliente_nit,
    factura.nitfac,
    factura.estado AS estado_factura,
    factura.numfac
   FROM ((((public.venta
     JOIN public.cliente ON ((venta.codcli = cliente.codcli)))
     JOIN public.usuario ON ((usuario.codusu = cliente.codcli)))
     JOIN public.usuario u ON ((u.codusu = venta.codusu)))
     LEFT JOIN public.factura ON ((factura.codven = venta.codven)));
    DROP VIEW public.view_venta;
       public          postgres    false    243    243    243    243    243    243    243    243    243    243    243    243    243    242    242    242    218    218    218    218    218    207                      0    18646    acceso_sucursal 
   TABLE DATA           K   COPY public.acceso_sucursal (codusu, codsuc, fecalta, fecbaja) FROM stdin;
    public          postgres    false    200   m�                0    18649    accesousuario 
   TABLE DATA           F   COPY public.accesousuario (login, passwd, estado, codusu) FROM stdin;
    public          postgres    false    201   ��                 0    18653    almacen 
   TABLE DATA           A   COPY public.almacen (codlugar, cantidad, codalmacen) FROM stdin;
    public          postgres    false    202   �      !          0    18656    area 
   TABLE DATA           6   COPY public.area (codare, nombre, estado) FROM stdin;
    public          postgres    false    203   "�      "          0    18659    backup 
   TABLE DATA           9   COPY public.backup (cod, xuser, descripcion) FROM stdin;
    public          postgres    false    204   ]�      #          0    18665    caja 
   TABLE DATA           z   COPY public.caja (codcaja, codusu, fini, ffin, monini, monfin, monsistema, estado, codsuc, observacion, tipo) FROM stdin;
    public          postgres    false    205   ��      $          0    18672 	   categoria 
   TABLE DATA           ;   COPY public.categoria (codcat, nomcat, estado) FROM stdin;
    public          postgres    false    206   ��      %          0    18678    cliente 
   TABLE DATA           U   COPY public.cliente (estado, nit, direccion, celular, codcli, razon_nit) FROM stdin;
    public          postgres    false    207   ��      &          0    18685    compra 
   TABLE DATA           �   COPY public.compra (codcom, fecha, estado, codusu, codpro, tiponota, total, descuento, codcaja, coddetcaja, num, formapago, bonificacion, subtotal, numnota, codsuc, credito, estado_credito) FROM stdin;
    public          postgres    false    208   
�      '          0    18690    cuenta 
   TABLE DATA           A   COPY public.cuenta (codcuenta, nombre, estado, tipo) FROM stdin;
    public          postgres    false    209   ��      (          0    18693    detalle_margen 
   TABLE DATA           l   COPY public.detalle_margen (cod_margen, number_margin, concept, type_margin, porcentaje_unidad) FROM stdin;
    public          postgres    false    210   +�      )          0    18699    detalle_salida 
   TABLE DATA           s   COPY public.detalle_salida (codsal, codalmacen, cantidad, fingreso, fvencimiento, in_out, is_response) FROM stdin;
    public          postgres    false    211   k�      *          0    18703    detallecaja 
   TABLE DATA           [   COPY public.detallecaja (codcaja, coddetcaja, monto, fecha, estado, codcuenta) FROM stdin;
    public          postgres    false    212   ��      +          0    18707    detallecompra 
   TABLE DATA           �   COPY public.detallecompra (codcom, codpro, cantidad, precio, subtotal, fingreso, fvencimiento, codalmacen, coddcom, impuestos, devolucion, descuento, porcentaje_unidad, porcentaje_caja, porcentaje_paquete, tipo_compra) FROM stdin;
    public          postgres    false    213   ͋      ,          0    18710    detallepedido 
   TABLE DATA           S   COPY public.detallepedido (codped, codpro, cantidad, precio, subtotal) FROM stdin;
    public          postgres    false    214   P�      -          0    18713    detallepromo 
   TABLE DATA           m   COPY public.detallepromo (codpromo, codpro, descuento_unidad, descuento_caja, descuento_paquete) FROM stdin;
    public          postgres    false    215   m�      .          0    18716    detalleventa 
   TABLE DATA           t   COPY public.detalleventa (codpro, cantidad, codven, precio, subtotal, codalmacen, tipo_venta, codpromo) FROM stdin;
    public          postgres    false    216   ��      /          0    18719    dosificacion 
   TABLE DATA           �   COPY public.dosificacion (coddosificacion, razonsocial, direccion, telefono, lugar, nit, numaut, actividad, llave, leyenda, mensaje, flimite, ftramite, numtramite, sfc, est, codsuc, sigla, numinifac, numfinfac) FROM stdin;
    public          postgres    false    217         0          0    18725    factura 
   TABLE DATA           �   COPY public.factura (coddosificacion, numfac, fecfac, nitfac, codcontrol, estado, cliente_nit, codven, codcom, total) FROM stdin;
    public          postgres    false    218   ��      1          0    18728    laboratorio 
   TABLE DATA           =   COPY public.laboratorio (codlab, nombre, estado) FROM stdin;
    public          postgres    false    219   ��      2          0    18732    lugar 
   TABLE DATA           F   COPY public.lugar (codsuc, codpro, codposicion, codlugar) FROM stdin;
    public          postgres    false    220   l�      3          0    18735    margen 
   TABLE DATA           X   COPY public.margen (cod_margen, codusu, date_register, observacion, estado) FROM stdin;
    public          postgres    false    221   ��      4          0    18742    medida 
   TABLE DATA           8   COPY public.medida (codmed, nombre, estado) FROM stdin;
    public          postgres    false    222   �      5          0    18745    menu 
   TABLE DATA           4   COPY public.menu (codm, nombre, estado) FROM stdin;
    public          postgres    false    223   ��      6          0    18749    mepro 
   TABLE DATA           +   COPY public.mepro (codm, codp) FROM stdin;
    public          postgres    false    224   N�      7          0    18752    mueble 
   TABLE DATA           D   COPY public.mueble (codmueble, nombre, estado, codtimu) FROM stdin;
    public          postgres    false    225   Ӑ      8          0    18756    pagocredito 
   TABLE DATA           X   COPY public.pagocredito (codcom, fecha, fecreg, monto, codusu, observacion) FROM stdin;
    public          postgres    false    226   *�      9          0    18762    pedido 
   TABLE DATA           �   COPY public.pedido (codped, fecha, estado, codusu, celular, direccion, observacion, fentrega, coddelivery, nit, razon_nit, codven, codsuc) FROM stdin;
    public          postgres    false    227   ��      :          0    18769    posicion 
   TABLE DATA           J   COPY public.posicion (codposicion, nombre, estado, codmueble) FROM stdin;
    public          postgres    false    228   ��      ;          0    18773    presentacion 
   TABLE DATA           >   COPY public.presentacion (codpre, nombre, estado) FROM stdin;
    public          postgres    false    229   �      <          0    18779    proceso 
   TABLE DATA           ?   COPY public.proceso (codp, nombre, enlace, estado) FROM stdin;
    public          postgres    false    230   y�      =          0    18783    producto 
   TABLE DATA           ?  COPY public.producto (codpro, nombre, estado, foto, codtip, generico, codigobarra, codlab, concentracion, codmed, codare, pc_unit, pv_unit, porcentaje_unidad, codpre, controlado, inventario_minimo_unidad, pareto, unixcaja, pv_caja, pv_descuento_caja, pc_caja, unixpaquete, uni_en_paquete, inventario_minimo_caja, inventario_minimo_paquete, pc_paquete, pv_paquete, porcentaje_caja, porcentaje_paquete, tipo_compra, pv_descuento_paquete, presentacion_unidad, presentacion_caja, presentacion_paquete, margen, porcentaje_descuento_caja, porcentaje_descuento_paquete) FROM stdin;
    public          postgres    false    231   ��      >          0    18792    producto_nuevo 
   TABLE DATA           \   COPY public.producto_nuevo (cod_pro_nuevo, nombre, descripcion, estado, codusu) FROM stdin;
    public          postgres    false    232   �      ?          0    18796 	   promocion 
   TABLE DATA           t   COPY public.promocion (codpromo, fcreacion, fini, ffin, titulo, descripcion, codusu, estpromo, gestion) FROM stdin;
    public          postgres    false    233   9�      @          0    18802 	   proveedor 
   TABLE DATA           [   COPY public.proveedor (codproveedor, nombre, nit, direccion, telefono, estado) FROM stdin;
    public          postgres    false    234   V�      A          0    18806    rol 
   TABLE DATA           A   COPY public.rol (codr, nombre, estado, acceso_venta) FROM stdin;
    public          postgres    false    235   ��      B          0    18811    rolme 
   TABLE DATA           +   COPY public.rolme (codr, codm) FROM stdin;
    public          postgres    false    236   �      C          0    18814    rolusu 
   TABLE DATA           -   COPY public.rolusu (codr, login) FROM stdin;
    public          postgres    false    237   '�      D          0    18817    salida 
   TABLE DATA           �   COPY public.salida (codsal, fsalida, codusu, tipo, descripcion, estado, est, numero, suc_origen, suc_destino, in_out, solucion, monto, conclusion) FROM stdin;
    public          postgres    false    238   N�      E          0    18823    sucursal 
   TABLE DATA           O   COPY public.sucursal (codsuc, nombre, telefono, estado, direccion) FROM stdin;
    public          postgres    false    239   k�      F          0    18829    tipo 
   TABLE DATA           >   COPY public.tipo (codtip, nomtip, estado, codcat) FROM stdin;
    public          postgres    false    240   �      G          0    18835    tipo_mueble 
   TABLE DATA           >   COPY public.tipo_mueble (codtimu, nombre, estado) FROM stdin;
    public          postgres    false    241   �      H          0    18838    usuario 
   TABLE DATA           q   COPY public.usuario (codusu, nombre, ap, am, genero, estado, tipoper, foto, ci, fnac, ecivil, alias) FROM stdin;
    public          postgres    false    242   1�      I          0    18843    venta 
   TABLE DATA           �   COPY public.venta (codven, fecha, estado, codcli, tiponota, codcaja, coddetcaja, formapago, total, codusu, total_pagado, cambio, codsuc) FROM stdin;
    public          postgres    false    243   ��                 2606    18878 "   acceso_sucursal acceso_sucursal_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.acceso_sucursal
    ADD CONSTRAINT acceso_sucursal_pk PRIMARY KEY (codusu, codsuc, fecalta);
 L   ALTER TABLE ONLY public.acceso_sucursal DROP CONSTRAINT acceso_sucursal_pk;
       public            postgres    false    200    200    200                       2606    18880    almacen almacen6_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.almacen
    ADD CONSTRAINT almacen6_pk PRIMARY KEY (codalmacen);
 =   ALTER TABLE ONLY public.almacen DROP CONSTRAINT almacen6_pk;
       public            postgres    false    202            8           2606    18882    lugar almacen_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public.lugar
    ADD CONSTRAINT almacen_pk PRIMARY KEY (codlugar);
 :   ALTER TABLE ONLY public.lugar DROP CONSTRAINT almacen_pk;
       public            postgres    false    220                       2606    18884    area area_pk 
   CONSTRAINT     N   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pk PRIMARY KEY (codare);
 6   ALTER TABLE ONLY public.area DROP CONSTRAINT area_pk;
       public            postgres    false    203                       2606    18886    backup backup_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.backup
    ADD CONSTRAINT backup_pkey PRIMARY KEY (cod);
 <   ALTER TABLE ONLY public.backup DROP CONSTRAINT backup_pkey;
       public            postgres    false    204                       2606    18888    caja caja_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.caja
    ADD CONSTRAINT caja_pkey PRIMARY KEY (codcaja);
 8   ALTER TABLE ONLY public.caja DROP CONSTRAINT caja_pkey;
       public            postgres    false    205                       2606    18890    categoria categoria_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (codcat);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public            postgres    false    206                       2606    18892    cliente cliente_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (codcli);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    207                        2606    18894    compra compra_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (codcom);
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_pkey;
       public            postgres    false    208            "           2606    18896    cuenta cuenta_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_pk PRIMARY KEY (codcuenta);
 :   ALTER TABLE ONLY public.cuenta DROP CONSTRAINT cuenta_pk;
       public            postgres    false    209            $           2606    18898 "   detalle_margen detalle_margen_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.detalle_margen
    ADD CONSTRAINT detalle_margen_pkey PRIMARY KEY (cod_margen, number_margin);
 L   ALTER TABLE ONLY public.detalle_margen DROP CONSTRAINT detalle_margen_pkey;
       public            postgres    false    210    210            &           2606    18900 "   detalle_salida detalle_salida_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT detalle_salida_pkey PRIMARY KEY (codsal, codalmacen);
 L   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT detalle_salida_pkey;
       public            postgres    false    211    211            (           2606    18902    detallecaja detallecaja_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.detallecaja
    ADD CONSTRAINT detallecaja_pkey PRIMARY KEY (codcaja, coddetcaja);
 F   ALTER TABLE ONLY public.detallecaja DROP CONSTRAINT detallecaja_pkey;
       public            postgres    false    212    212            *           2606    18904    detallecompra detallecompra_pk 
   CONSTRAINT     i   ALTER TABLE ONLY public.detallecompra
    ADD CONSTRAINT detallecompra_pk PRIMARY KEY (codcom, coddcom);
 H   ALTER TABLE ONLY public.detallecompra DROP CONSTRAINT detallecompra_pk;
       public            postgres    false    213    213            ,           2606    18906     detallepedido detallepedido_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_pkey PRIMARY KEY (codped, codpro);
 J   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT detallepedido_pkey;
       public            postgres    false    214    214            .           2606    18908    detallepromo detallepromo_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.detallepromo
    ADD CONSTRAINT detallepromo_pkey PRIMARY KEY (codpromo, codpro);
 H   ALTER TABLE ONLY public.detallepromo DROP CONSTRAINT detallepromo_pkey;
       public            postgres    false    215    215            0           2606    18910    detalleventa detalleventa_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.detalleventa
    ADD CONSTRAINT detalleventa_pkey PRIMARY KEY (codpro, codven);
 H   ALTER TABLE ONLY public.detalleventa DROP CONSTRAINT detalleventa_pkey;
       public            postgres    false    216    216            2           2606    18912    dosificacion dosificacion_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.dosificacion
    ADD CONSTRAINT dosificacion_pkey PRIMARY KEY (coddosificacion);
 H   ALTER TABLE ONLY public.dosificacion DROP CONSTRAINT dosificacion_pkey;
       public            postgres    false    217            4           2606    18914    factura factura_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (coddosificacion, numfac);
 >   ALTER TABLE ONLY public.factura DROP CONSTRAINT factura_pkey;
       public            postgres    false    218    218            6           2606    18916    laboratorio laboratorio_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.laboratorio
    ADD CONSTRAINT laboratorio_pk PRIMARY KEY (codlab);
 D   ALTER TABLE ONLY public.laboratorio DROP CONSTRAINT laboratorio_pk;
       public            postgres    false    219            :           2606    18918    margen margen_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.margen
    ADD CONSTRAINT margen_pkey PRIMARY KEY (cod_margen);
 <   ALTER TABLE ONLY public.margen DROP CONSTRAINT margen_pkey;
       public            postgres    false    221            <           2606    18920    medida medida_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.medida
    ADD CONSTRAINT medida_pk PRIMARY KEY (codmed);
 :   ALTER TABLE ONLY public.medida DROP CONSTRAINT medida_pk;
       public            postgres    false    222            >           2606    18922    menu menus_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menus_pkey PRIMARY KEY (codm);
 9   ALTER TABLE ONLY public.menu DROP CONSTRAINT menus_pkey;
       public            postgres    false    223            @           2606    18924    mepro mepro_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.mepro
    ADD CONSTRAINT mepro_pkey PRIMARY KEY (codm, codp);
 :   ALTER TABLE ONLY public.mepro DROP CONSTRAINT mepro_pkey;
       public            postgres    false    224    224            B           2606    18926    mueble mueble_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.mueble
    ADD CONSTRAINT mueble_pkey PRIMARY KEY (codmueble);
 <   ALTER TABLE ONLY public.mueble DROP CONSTRAINT mueble_pkey;
       public            postgres    false    225            b           2606    18928    tipo_mueble newtable_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.tipo_mueble
    ADD CONSTRAINT newtable_pk PRIMARY KEY (codtimu);
 A   ALTER TABLE ONLY public.tipo_mueble DROP CONSTRAINT newtable_pk;
       public            postgres    false    241            D           2606    18930    pagocredito pagocredito_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.pagocredito
    ADD CONSTRAINT pagocredito_pkey PRIMARY KEY (codcom);
 F   ALTER TABLE ONLY public.pagocredito DROP CONSTRAINT pagocredito_pkey;
       public            postgres    false    226            F           2606    18932    pedido pedido_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (codped);
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_pkey;
       public            postgres    false    227            d           2606    18934    usuario personas_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT personas_pkey PRIMARY KEY (codusu);
 ?   ALTER TABLE ONLY public.usuario DROP CONSTRAINT personas_pkey;
       public            postgres    false    242            H           2606    18936    posicion posicion_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.posicion
    ADD CONSTRAINT posicion_pkey PRIMARY KEY (codposicion);
 @   ALTER TABLE ONLY public.posicion DROP CONSTRAINT posicion_pkey;
       public            postgres    false    228            J           2606    18938    presentacion presentacion_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.presentacion
    ADD CONSTRAINT presentacion_pkey PRIMARY KEY (codpre);
 H   ALTER TABLE ONLY public.presentacion DROP CONSTRAINT presentacion_pkey;
       public            postgres    false    229            L           2606    18940    proceso procesos_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.proceso
    ADD CONSTRAINT procesos_pkey PRIMARY KEY (codp);
 ?   ALTER TABLE ONLY public.proceso DROP CONSTRAINT procesos_pkey;
       public            postgres    false    230            P           2606    18942 "   producto_nuevo producto_nuevo_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.producto_nuevo
    ADD CONSTRAINT producto_nuevo_pkey PRIMARY KEY (cod_pro_nuevo);
 L   ALTER TABLE ONLY public.producto_nuevo DROP CONSTRAINT producto_nuevo_pkey;
       public            postgres    false    232            N           2606    18944    producto producto_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (codpro);
 @   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_pkey;
       public            postgres    false    231            R           2606    18946    promocion promocion_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.promocion
    ADD CONSTRAINT promocion_pkey PRIMARY KEY (codpromo);
 B   ALTER TABLE ONLY public.promocion DROP CONSTRAINT promocion_pkey;
       public            postgres    false    233            T           2606    18948    proveedor proveedor_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (codproveedor);
 B   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT proveedor_pkey;
       public            postgres    false    234            V           2606    18950    rol roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.rol
    ADD CONSTRAINT roles_pkey PRIMARY KEY (codr);
 8   ALTER TABLE ONLY public.rol DROP CONSTRAINT roles_pkey;
       public            postgres    false    235            X           2606    18952    rolme rolme_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.rolme
    ADD CONSTRAINT rolme_pkey PRIMARY KEY (codr, codm);
 :   ALTER TABLE ONLY public.rolme DROP CONSTRAINT rolme_pkey;
       public            postgres    false    236    236            Z           2606    18954    rolusu rolusu_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.rolusu
    ADD CONSTRAINT rolusu_pkey PRIMARY KEY (codr, login);
 <   ALTER TABLE ONLY public.rolusu DROP CONSTRAINT rolusu_pkey;
       public            postgres    false    237    237            \           2606    18956    salida salida_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.salida
    ADD CONSTRAINT salida_pkey PRIMARY KEY (codsal);
 <   ALTER TABLE ONLY public.salida DROP CONSTRAINT salida_pkey;
       public            postgres    false    238            ^           2606    18958    sucursal sucursal_pk 
   CONSTRAINT     V   ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pk PRIMARY KEY (codsuc);
 >   ALTER TABLE ONLY public.sucursal DROP CONSTRAINT sucursal_pk;
       public            postgres    false    239            `           2606    18960    tipo tipo_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.tipo
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (codtip);
 8   ALTER TABLE ONLY public.tipo DROP CONSTRAINT tipo_pkey;
       public            postgres    false    240                       2606    18962 !   accesousuario usuarios_codper_key 
   CONSTRAINT     ^   ALTER TABLE ONLY public.accesousuario
    ADD CONSTRAINT usuarios_codper_key UNIQUE (codusu);
 K   ALTER TABLE ONLY public.accesousuario DROP CONSTRAINT usuarios_codper_key;
       public            postgres    false    201                       2606    18964    accesousuario usuarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.accesousuario
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (login);
 E   ALTER TABLE ONLY public.accesousuario DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    201            f           2606    18966    venta venta_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (codven);
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public            postgres    false    243            g           2606    18967 +   acceso_sucursal acceso_sucursal_sucursal_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.acceso_sucursal
    ADD CONSTRAINT acceso_sucursal_sucursal_fk FOREIGN KEY (codsuc) REFERENCES public.sucursal(codsuc);
 U   ALTER TABLE ONLY public.acceso_sucursal DROP CONSTRAINT acceso_sucursal_sucursal_fk;
       public          postgres    false    239    200    3166            h           2606    18972 +   acceso_sucursal acceso_sucursal_usuarios_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.acceso_sucursal
    ADD CONSTRAINT acceso_sucursal_usuarios_fk FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 U   ALTER TABLE ONLY public.acceso_sucursal DROP CONSTRAINT acceso_sucursal_usuarios_fk;
       public          postgres    false    200    242    3172            j           2606    18977    almacen almacen_lugar_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.almacen
    ADD CONSTRAINT almacen_lugar_fk FOREIGN KEY (codlugar) REFERENCES public.lugar(codlugar);
 B   ALTER TABLE ONLY public.almacen DROP CONSTRAINT almacen_lugar_fk;
       public          postgres    false    3128    202    220            k           2606    18982    caja caja_codusu_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.caja
    ADD CONSTRAINT caja_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 ?   ALTER TABLE ONLY public.caja DROP CONSTRAINT caja_codusu_fkey;
       public          postgres    false    242    205    3172            l           2606    18987    caja caja_sucursal_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.caja
    ADD CONSTRAINT caja_sucursal_fk FOREIGN KEY (codsuc) REFERENCES public.sucursal(codsuc);
 ?   ALTER TABLE ONLY public.caja DROP CONSTRAINT caja_sucursal_fk;
       public          postgres    false    239    205    3166            m           2606    18992    cliente cliente_codcli_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_codcli_fkey FOREIGN KEY (codcli) REFERENCES public.usuario(codusu);
 E   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_codcli_fkey;
       public          postgres    false    3172    242    207            n           2606    18997    compra compra_codpro_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_codpro_fkey FOREIGN KEY (codpro) REFERENCES public.proveedor(codproveedor);
 C   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_codpro_fkey;
       public          postgres    false    234    208    3156            o           2606    19002    compra compra_codusu_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 C   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_codusu_fkey;
       public          postgres    false    3172    208    242            p           2606    19007    compra compra_detallecaja_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_detallecaja_fk FOREIGN KEY (codcaja, coddetcaja) REFERENCES public.detallecaja(codcaja, coddetcaja);
 F   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_detallecaja_fk;
       public          postgres    false    3112    208    212    208    212            q           2606    19012 -   detalle_margen detalle_margen_cod_margen_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_margen
    ADD CONSTRAINT detalle_margen_cod_margen_fkey FOREIGN KEY (cod_margen) REFERENCES public.margen(cod_margen);
 W   ALTER TABLE ONLY public.detalle_margen DROP CONSTRAINT detalle_margen_cod_margen_fkey;
       public          postgres    false    221    210    3130            r           2606    19017 )   detalle_salida detalle_salida_codsal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT detalle_salida_codsal_fkey FOREIGN KEY (codsal) REFERENCES public.salida(codsal);
 S   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT detalle_salida_codsal_fkey;
       public          postgres    false    211    3164    238            s           2606    19022 $   detallecaja detallecaja_codcaja_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallecaja
    ADD CONSTRAINT detallecaja_codcaja_fkey FOREIGN KEY (codcaja) REFERENCES public.caja(codcaja);
 N   ALTER TABLE ONLY public.detallecaja DROP CONSTRAINT detallecaja_codcaja_fkey;
       public          postgres    false    212    205    3098            t           2606    19027 !   detallecaja detallecaja_cuenta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallecaja
    ADD CONSTRAINT detallecaja_cuenta_fk FOREIGN KEY (codcuenta) REFERENCES public.cuenta(codcuenta);
 K   ALTER TABLE ONLY public.detallecaja DROP CONSTRAINT detallecaja_cuenta_fk;
       public          postgres    false    212    209    3106            u           2606    19032 &   detallecompra detallecompra_almacen_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallecompra
    ADD CONSTRAINT detallecompra_almacen_fk FOREIGN KEY (codalmacen) REFERENCES public.almacen(codalmacen);
 P   ALTER TABLE ONLY public.detallecompra DROP CONSTRAINT detallecompra_almacen_fk;
       public          postgres    false    213    3092    202            v           2606    19037 '   detallecompra detallecompra_codcom_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallecompra
    ADD CONSTRAINT detallecompra_codcom_fkey FOREIGN KEY (codcom) REFERENCES public.compra(codcom);
 Q   ALTER TABLE ONLY public.detallecompra DROP CONSTRAINT detallecompra_codcom_fkey;
       public          postgres    false    3104    208    213            w           2606    19042 '   detallepedido detallepedido_codped_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_codped_fkey FOREIGN KEY (codped) REFERENCES public.pedido(codped);
 Q   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT detallepedido_codped_fkey;
       public          postgres    false    3142    214    227            x           2606    19047 '   detallepromo detallepromo_codpromo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallepromo
    ADD CONSTRAINT detallepromo_codpromo_fkey FOREIGN KEY (codpromo) REFERENCES public.promocion(codpromo);
 Q   ALTER TABLE ONLY public.detallepromo DROP CONSTRAINT detallepromo_codpromo_fkey;
       public          postgres    false    215    3154    233            y           2606    19052 #   detalleventa detalleventa_codv_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalleventa
    ADD CONSTRAINT detalleventa_codv_fkey FOREIGN KEY (codven) REFERENCES public.venta(codven);
 M   ALTER TABLE ONLY public.detalleventa DROP CONSTRAINT detalleventa_codv_fkey;
       public          postgres    false    3174    216    243            z           2606    19057 %   dosificacion dosificacion_sucursal_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.dosificacion
    ADD CONSTRAINT dosificacion_sucursal_fk FOREIGN KEY (codsuc) REFERENCES public.sucursal(codsuc);
 O   ALTER TABLE ONLY public.dosificacion DROP CONSTRAINT dosificacion_sucursal_fk;
       public          postgres    false    217    239    3166            {           2606    19062    factura factura_ibfk_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_ibfk_1 FOREIGN KEY (coddosificacion) REFERENCES public.dosificacion(coddosificacion);
 @   ALTER TABLE ONLY public.factura DROP CONSTRAINT factura_ibfk_1;
       public          postgres    false    217    218    3122            |           2606    19067    lugar lugar_posicion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lugar
    ADD CONSTRAINT lugar_posicion_fk FOREIGN KEY (codposicion) REFERENCES public.posicion(codposicion);
 A   ALTER TABLE ONLY public.lugar DROP CONSTRAINT lugar_posicion_fk;
       public          postgres    false    228    3144    220            }           2606    19072    lugar lugar_producto_fk    FK CONSTRAINT     |   ALTER TABLE ONLY public.lugar
    ADD CONSTRAINT lugar_producto_fk FOREIGN KEY (codpro) REFERENCES public.producto(codpro);
 A   ALTER TABLE ONLY public.lugar DROP CONSTRAINT lugar_producto_fk;
       public          postgres    false    220    3150    231            ~           2606    19077    lugar lugar_sucursal_fk    FK CONSTRAINT     |   ALTER TABLE ONLY public.lugar
    ADD CONSTRAINT lugar_sucursal_fk FOREIGN KEY (codsuc) REFERENCES public.sucursal(codsuc);
 A   ALTER TABLE ONLY public.lugar DROP CONSTRAINT lugar_sucursal_fk;
       public          postgres    false    239    3166    220                       2606    19082    margen margen_codusu_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.margen
    ADD CONSTRAINT margen_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 C   ALTER TABLE ONLY public.margen DROP CONSTRAINT margen_codusu_fkey;
       public          postgres    false    221    242    3172            �           2606    19087    mepro mepro_codm_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY public.mepro
    ADD CONSTRAINT mepro_codm_fkey FOREIGN KEY (codm) REFERENCES public.menu(codm);
 ?   ALTER TABLE ONLY public.mepro DROP CONSTRAINT mepro_codm_fkey;
       public          postgres    false    3134    224    223            �           2606    19092    mepro mepro_codp_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY public.mepro
    ADD CONSTRAINT mepro_codp_fkey FOREIGN KEY (codp) REFERENCES public.proceso(codp);
 ?   ALTER TABLE ONLY public.mepro DROP CONSTRAINT mepro_codp_fkey;
       public          postgres    false    3148    224    230            �           2606    19097    mueble mueble_tipo_mueble_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.mueble
    ADD CONSTRAINT mueble_tipo_mueble_fk FOREIGN KEY (codtimu) REFERENCES public.tipo_mueble(codtimu);
 F   ALTER TABLE ONLY public.mueble DROP CONSTRAINT mueble_tipo_mueble_fk;
       public          postgres    false    225    241    3170            �           2606    19102 #   pagocredito pagocredito_codcom_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagocredito
    ADD CONSTRAINT pagocredito_codcom_fkey FOREIGN KEY (codcom) REFERENCES public.compra(codcom);
 M   ALTER TABLE ONLY public.pagocredito DROP CONSTRAINT pagocredito_codcom_fkey;
       public          postgres    false    3104    226    208            �           2606    19107    pedido pedido_codusu_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 C   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_codusu_fkey;
       public          postgres    false    242    3172    227            �           2606    19112    posicion posicion_mueble_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.posicion
    ADD CONSTRAINT posicion_mueble_fk FOREIGN KEY (codmueble) REFERENCES public.mueble(codmueble);
 E   ALTER TABLE ONLY public.posicion DROP CONSTRAINT posicion_mueble_fk;
       public          postgres    false    228    225    3138            �           2606    19117    producto producto_area_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_area_fk FOREIGN KEY (codare) REFERENCES public.area(codare);
 C   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_area_fk;
       public          postgres    false    203    3094    231            �           2606    19122    producto producto_codtip_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_codtip_fkey FOREIGN KEY (codtip) REFERENCES public.tipo(codtip);
 G   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_codtip_fkey;
       public          postgres    false    3168    231    240            �           2606    19127     producto producto_laboratorio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_laboratorio_fk FOREIGN KEY (codlab) REFERENCES public.laboratorio(codlab);
 J   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_laboratorio_fk;
       public          postgres    false    231    219    3126            �           2606    19132    producto producto_medida_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_medida_fk FOREIGN KEY (codmed) REFERENCES public.medida(codmed);
 E   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_medida_fk;
       public          postgres    false    231    222    3132            �           2606    19137 !   producto producto_presentacion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_presentacion_fk FOREIGN KEY (codpre) REFERENCES public.presentacion(codpre);
 K   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_presentacion_fk;
       public          postgres    false    229    231    3146            �           2606    19142    promocion promocion_codusu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.promocion
    ADD CONSTRAINT promocion_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 I   ALTER TABLE ONLY public.promocion DROP CONSTRAINT promocion_codusu_fkey;
       public          postgres    false    3172    242    233            �           2606    19147 %   proveedor proveedor_codproveedor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_codproveedor_fkey FOREIGN KEY (codproveedor) REFERENCES public.usuario(codusu);
 O   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT proveedor_codproveedor_fkey;
       public          postgres    false    242    234    3172            �           2606    19152    rolme rolme_codm_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY public.rolme
    ADD CONSTRAINT rolme_codm_fkey FOREIGN KEY (codm) REFERENCES public.menu(codm);
 ?   ALTER TABLE ONLY public.rolme DROP CONSTRAINT rolme_codm_fkey;
       public          postgres    false    236    223    3134            �           2606    19157    rolme rolme_rolme_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY public.rolme
    ADD CONSTRAINT rolme_rolme_fkey FOREIGN KEY (codr) REFERENCES public.rol(codr);
 @   ALTER TABLE ONLY public.rolme DROP CONSTRAINT rolme_rolme_fkey;
       public          postgres    false    3158    235    236            �           2606    19162    rolusu rolusu_codr_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY public.rolusu
    ADD CONSTRAINT rolusu_codr_fkey FOREIGN KEY (codr) REFERENCES public.rol(codr);
 A   ALTER TABLE ONLY public.rolusu DROP CONSTRAINT rolusu_codr_fkey;
       public          postgres    false    237    235    3158            �           2606    19167    rolusu rolusu_login_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rolusu
    ADD CONSTRAINT rolusu_login_fkey FOREIGN KEY (login) REFERENCES public.accesousuario(login);
 B   ALTER TABLE ONLY public.rolusu DROP CONSTRAINT rolusu_login_fkey;
       public          postgres    false    3090    237    201            �           2606    19172    salida salida_codusu_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.salida
    ADD CONSTRAINT salida_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 C   ALTER TABLE ONLY public.salida DROP CONSTRAINT salida_codusu_fkey;
       public          postgres    false    242    238    3172            �           2606    19177    salida salida_suc_destino_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.salida
    ADD CONSTRAINT salida_suc_destino_fkey FOREIGN KEY (suc_destino) REFERENCES public.sucursal(codsuc);
 H   ALTER TABLE ONLY public.salida DROP CONSTRAINT salida_suc_destino_fkey;
       public          postgres    false    239    3166    238            �           2606    19182    salida salida_suc_origen_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.salida
    ADD CONSTRAINT salida_suc_origen_fkey FOREIGN KEY (suc_origen) REFERENCES public.sucursal(codsuc);
 G   ALTER TABLE ONLY public.salida DROP CONSTRAINT salida_suc_origen_fkey;
       public          postgres    false    238    3166    239            �           2606    19187    tipo tipo_codcat_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.tipo
    ADD CONSTRAINT tipo_codcat_fkey FOREIGN KEY (codcat) REFERENCES public.categoria(codcat);
 ?   ALTER TABLE ONLY public.tipo DROP CONSTRAINT tipo_codcat_fkey;
       public          postgres    false    3100    240    206            i           2606    19192 "   accesousuario usuarios_codusu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesousuario
    ADD CONSTRAINT usuarios_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 L   ALTER TABLE ONLY public.accesousuario DROP CONSTRAINT usuarios_codusu_fkey;
       public          postgres    false    201    242    3172            �           2606    19197    venta venta_codcaja_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_codcaja_fkey FOREIGN KEY (codcaja, coddetcaja) REFERENCES public.detallecaja(codcaja, coddetcaja);
 B   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_codcaja_fkey;
       public          postgres    false    3112    212    243    212    243               (   x�3�4�4202�54�5�T0��2��26�������� \�         3   x�KL����L����\�@Ҙ+9'��9M��S��Jr�r��qqq ��0          *   x�ȱ 0��?L�a��#�T�R�����;�9*�^��      !   +   x�3��w�,�2�t��K.J-I,�L8��+S�!�=... ��      "   :   x�3�420�4424�74063��KJL�.-�tN,�IT�O�LTp/JLOMI����� I��      #   9   x�3�4�4202�54�50T0��21�24�3�04������440�Q�@br��qqq =�
=      $   �   x�u���0�g�)���S`DP��eAbqS��I�����Ell��|g��ښ>o\V-,y��3�C���a$����"�x9�k�q߈Ij�8�	;���4:�-���&�e5=����I�]�W�q�.�t�}��f^@Cڹ5�K� k����Y��%p�_E���pv_1�>'�R0      %   B   x�-�� 1��PL&�9�H鿎������^S�	�U�0OL۟~�o�!�F_��U� �]�      &   |   x�}���0D�a�.�
�p�v�N��L��U��|�#,��<����a�9Z<9�w��;��a��,��dS���=? '�����eW�q�?%0��Q4���_��)9��Q����?�~-+      '   �   x�]�1�0Eg�9j��b`E���Su ��������١pN��2(.tn�
�pԌ��I~j�{�?�����C�ZOk�e1B��\E[n��:\I{�~%G��L���͋�P�G��W�;���5D�      (   0   x�3�4�L�Q((��M-R�M,JO����W�urw��4����� �E
�      )      x������ � �      *   5   x�3�4�44��3�4202�54�50T0��25�20�32�400+1����� �,      +   s   x�m��	�@Dϳ�(h�qp��g�_B�Ř�1#���Z�PQmj*��|RhbY�8�m����b�־���y�pt���~�r�逷��76j����2�I�;O�D���|�j�1>��&�      ,      x������ � �      -      x������ � �      .   (   x�3�4A#�?.N�XϘ�L��
��qqq ���      /   �   x�=�M��0��oEa�XI�$b{Q���?����n��H�?ߊ 33����K��4q,d�o�ʐ
>�n8U&�3W�Z];|�Emq	&�E|m����yH�S����lɾ��s��1��m���d*W�nq���By]�Hn��3���?���+� I(&(�H(p�UY�W��i���G:FB"Տ����@+      0      x������ � �      1   �   x�]�=�0E��_�ƺA�cD�J��%qqy�I�>S �/q��{#Py�B/�\K��eI��b�8ew�yO�� ��\��έ�^���-��^(S�-�i����=�S�}[���7��}S7?XÍ{�l�O��]Ȍ�`�	kmP>�Q�|C�L��B� d�DT      2   &   x�3�4�4�4�2�4�F@�Hi3 m����� SY      3   @   x�3�4�4202�54�56P02�25�2��364��0���S�O*N-*KL���K-�,����� X%�      4   �   x�E��
�0@��W�/bՁ�wԝě�ٖl��m�޴
H��#�"ҕ�<n`1��=�]s��\�	�j���!�!-,b�>�}���k@�p��K�i�*���?���J�z�8 �(Q���=���g���֊�$
{l�1�X9�      5   �   x�M�;�0D��)|'|k#Q!E!��Y�����ڡ���.��7����`��w�=(�/���q���fq���Eƙ�����v%�F����@sn�A�h=Iϵ��k�rl�X	� �Ӧ�Fǩ�=��1�T�A�z�7%��/v�L�ϭ��ݸ!�l�_�QN}      6   u   x���E!�5)����������q �q�#v\d�B����S��V���!��K��u�:j5c+�����k�D�e��c<�7m�}�I�]�%���ц&_]�q�� ��"       7   G   x�3��P��O�4�4�2����4��8��"���`ڄ�Ls:�i#N'0m��XT���X�8 b���� �r�      8   Q   x�3�4002�54�56�4�3����M�����-,̍�9M89�2sS�
���K�R��S��s���b���� �l      9      x������ � �      :   J   x�3���/�L����4�4�24�t,*�LJ���8��#.Cc����	�ojJf>�c�阔����qqq M�q      ;   g   x��1�0��9LKJ+v2���]>�R����p�Ɠ�,��X�!��'_��r�--|ԋͣ���D�e%��Z��A~k�i�itD��O�d��V��7c�=�~      <   W  x�u�Kn�0���)t�ږ�^&�[d�"���
#�1K�@�F�ӳ�b>,�g7�|��yf�0�TM�b,h���6��S�,�{�Y���.�m<rޓU�<ǽI�)ջQ*-���H�Y�M/�"LvS�T�A���3�xg5p�T��|���t�K�Dc=Y�A�&�`����d�2K��,!
8��W�lUZ�������:�	'J�ٮ'>y�1'��:U�4���=c�]oYh�a�}�*F�0���b�ѠO��^�J�j�`�og� �59ƛ�=g;�:я��	�k�VȘ��ek�V���[,(�b��p��J��3h�(������
�;lʞ�!BU�߈� c�}��z���J{_>&w(?��ԅĸxA�8�C3��l����ʹ}�B/�?U�'i:�i��ccŅ.��|'�*���x"�,Y�M�����Ii9h�9_�~b���w`���O"�y��I2�����O΁k�v�1JQ����o���%ۚ�p`�C�w?>t��t�`�`Z�I���-��7�=�G�>�g������c�����4��
��P:�a_���(xW7�/��%I����I      =   ,  x��R�n�0=���%a��֢��2�����4�˾~v+�����$~Oy'���������u�DߞA)��R�q��O±�a��=Fa(�<�
���Ե7Y��U�jT�t�ą��[�M�߼?��*u�A)#*��D0�xؗh�8GB1�`�l�z�S�@���w��癍�-��%Vf7������&wZ/���2��5h��=�_��_�?"�x0��ԟ�M�Lh�����mQ�_{5�pW~�2�bw��~��7*���?��0ז(L�*�2���vΞz���r�����QDQ��Ӱ�      >      x������ � �      ?      x������ � �      @   ?   x�3���vT�qTp��4426153����ITH�Rp���,�L�43�02206�4����� lV{      A   ,   x�3�tt���S�q��4�,�2�y�9����b���� �h	�      B   6   x�ʱ  �����b���8W��㢱p`'��d.s�����7%}t	x      C      x�3�LL����2��1z\\\ @E      D      x������ � �      E   �   x�U�I
�@�ݧx�6�������G�����D0�� �^�\�n\UFM)�T��՞�C�Lbz�T�k�y8S�"��O$i'�R3vy���X_���9awjQwUV�+	�`���_t!�u��c�'�	.1�������S@���.�Z ��6�      F   �  x�u��n�0Eף������p��H�����̀&��h��C�������p^Wmg�w�A��,����r����J;��4Fv.��n��?"�a3�4��=�WTG�GT�V��Ol7���48��G�L7H��[G
���/�T��gIc3�Ǳ;�ww5ܑ���X[e��R���~TV�C�q�a����v:���Z)�CP����`B�3�&��`��!j&9g�ᱬ�6�b���8򽣓>p��J�5���^���
��t����ְ5��_�ޘ��]�+��;����ӭ��<y���Vo��q�L��
�i��>E�<�e/RS�=X-Y-��f�
��	���#�Q�	��?9�Hm 
���|��H.�΅��2f�-D}�M"
�D�oTᵩ� ƍ�f.��b��)�3�:�g^��L���x����W��b�?7F^uc$���;���0joߒ$�_O(�      G      x�3����,�2�t-.I�+I�c���� MJ�      H   �   x����
�@���>�/�����Cn��n�kD⍐D�Y�?$�	������;�tE2X
�IG"C§._��~xN\�~�EQ�^��Z�̇�[r9	e@&�?�ת����Al�M��?H���JQ��:j��'fX()t*��4�١�#X �Q/K�m��KV���Ra��q�1ƾ�7Rh      I   0   x�5ű	  �:��$��.�?�6r�QTN�0Z=ߑ���i���     