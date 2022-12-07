package com.footsalhaja.domain.main;


import lombok.Data;


@Data
public class LocationDto {
	private int locationId;
	private String address;
	private String stadiumName;
	private String region;
	private float lat;
	private float lng;
}
