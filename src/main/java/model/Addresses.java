package model;

public class Addresses {

    private Integer AddressId;
    private Integer UserId;
    private String ReceiverName;
    private String Phone;
    private String Province;
    private String District;
    private String Ward;
    private String Street;
    private String AddressType;
    private Boolean IsDefault;
    private Boolean Deleted;

    public Addresses() {
    }

    public Addresses(Integer AddressId, Integer UserId, String ReceiverName,
            String Phone, String Province, String District, String Ward,
            String Street, String AddressType, Boolean IsDefault,
            Boolean Deleted) {

        this.AddressId = AddressId;
        this.UserId = UserId;
        this.ReceiverName = ReceiverName;
        this.Phone = Phone;
        this.Province = Province;
        this.District = District;
        this.Ward = Ward;
        this.Street = Street;
        this.AddressType = AddressType;
        this.IsDefault = IsDefault;
        this.Deleted = Deleted;
    }

    public Integer getAddressId() {
        return AddressId;
    }

    public void setAddressId(Integer AddressId) {
        this.AddressId = AddressId;
    }

    public Integer getUserId() {
        return UserId;
    }

    public void setUserId(Integer UserId) {
        this.UserId = UserId;
    }

    public String getReceiverName() {
        return ReceiverName;
    }

    public void setReceiverName(String ReceiverName) {
        this.ReceiverName = ReceiverName;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public String getProvince() {
        return Province;
    }

    public void setProvince(String Province) {
        this.Province = Province;
    }

    public String getDistrict() {
        return District;
    }

    public void setDistrict(String District) {
        this.District = District;
    }

    public String getWard() {
        return Ward;
    }

    public void setWard(String Ward) {
        this.Ward = Ward;
    }

    public String getStreet() {
        return Street;
    }

    public void setStreet(String Street) {
        this.Street = Street;
    }

    public String getAddressType() {
        return AddressType;
    }

    public void setAddressType(String AddressType) {
        this.AddressType = AddressType;
    }

    public Boolean getIsDefault() {
        return IsDefault;
    }

    public void setIsDefault(Boolean IsDefault) {
        this.IsDefault = IsDefault;
    }

    public Boolean getDeleted() {
        return Deleted;
    }

    public void setDeleted(Boolean Deleted) {
        this.Deleted = Deleted;
    }

}