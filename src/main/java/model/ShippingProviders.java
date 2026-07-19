package model;

/**
 *
 * @author HP
 */
public class ShippingProviders {

    private Integer ProviderId;
    private String ProviderName;
    private String Phone;
    private Boolean Status;
    private Boolean Deleted;

    public ShippingProviders() {
    }

    public ShippingProviders(Integer ProviderId, String ProviderName,
            String Phone, Boolean Status, Boolean Deleted) {
        this.ProviderId = ProviderId;
        this.ProviderName = ProviderName;
        this.Phone = Phone;
        this.Status = Status;
        this.Deleted = Deleted;
    }

    public Integer getProviderId() {
        return ProviderId;
    }

    public void setProviderId(Integer ProviderId) {
        this.ProviderId = ProviderId;
    }

    public String getProviderName() {
        return ProviderName;
    }

    public void setProviderName(String ProviderName) {
        this.ProviderName = ProviderName;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public Boolean getStatus() {
        return Status;
    }

    public void setStatus(Boolean Status) {
        this.Status = Status;
    }

    public Boolean getDeleted() {
        return Deleted;
    }

    public void setDeleted(Boolean Deleted) {
        this.Deleted = Deleted;
    }

}